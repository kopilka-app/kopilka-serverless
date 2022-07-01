variable "global_name" { default = "kopilka-api" }

provider "aws" {
  region = "eu-central-1"
  profile = "default"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir = "./lib"
  output_path = "./builds/lambda"
}

resource "aws_lambda_function" "lambda" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = var.global_name
  role          = aws_iam_role.lambda.arn

  source_code_hash = filebase64sha256(data.archive_file.lambda_zip.output_path)
  memory_size      = 128
  timeout          = 60

  runtime = "ruby2.7"
  handler = "app.App::Handler.process"
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
