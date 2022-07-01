variable "global_name" { default = "savings" }

provider "aws" {
  region = "eu-central-1"
}
resource "aws_iam_role" "lambda" {
  name = var.global_name

  assume_role_policy = <<-POLICY
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "lambda.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
        }
      ]
    }
  POLICY
}

data "archive_file" "lambda_zip" {
  type = "zip"
  source_dir = "./dist/src"
  output_path = "./builds.zip"
}

resource "aws_lambda_function" "savings" {
  function_name    = var.global_name
  role             = aws_iam_role.lambda.arn

  filename         = data.archive_file.lambda_zip.output_path
  handler          = "handler.Route.call"
  runtime          = "ruby2.7"
  
  source_code_hash = filebase64sha256(data.archive_file.lambda_zip.output_path)
  memory_size      = 128
  timeout          = 60
}

resource "aws_apigatewayv2_api" "lambda" {
  name          = var.global_name
  protocol_type = "HTTP"
}

resource "aws_cloudwatch_log_group" "api_gw" {
  name = "/aws/api_gw/${aws_apigatewayv2_api.lambda.name}"

  retention_in_days = 30
}

resource "aws_apigatewayv2_stage" "lambda" {
  api_id = aws_apigatewayv2_api.lambda.id

  name        = "$default"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
    }
    )
  }
}

resource "aws_apigatewayv2_integration" "integration" {
  api_id = aws_apigatewayv2_api.lambda.id

  integration_uri    = aws_lambda_function.savings.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.savings.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.lambda.execution_arn}/*/*"
}

resource "aws_apigatewayv2_route" "get_index" {
  api_id             = aws_apigatewayv2_api.lambda.id
  route_key          = "ANY /savings"
  target             = "integrations/${aws_apigatewayv2_integration.integration.id}"
}


output "lambda_url" {
  value = aws_apigatewayv2_stage.lambda.invoke_url
}