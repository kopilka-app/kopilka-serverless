variable "global_name" { default = "kopilka-api" }
locals {
  endpoints = toset(["list_kopilka", "show_kopilka", "create_kopilka", "update_kopilka", "destroy_kopilka"])
}

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
  for_each = local.endpoints

  type = "zip"
  source_dir = "./dist/${each.key}"
  output_path = "./builds/${each.key}.zip"
}

resource "aws_lambda_function" "kopilka_api" {
  for_each      = local.endpoints
  function_name = each.key
  role          = aws_iam_role.lambda.arn

  filename      = "./builds/${each.key}.zip"
  handler = "lambda_handlers/${each.key}/handler.handler"
  runtime = "ruby2.7"
  
  source_code_hash = filebase64sha256("./builds/${each.key}.zip")
  memory_size      = 128
  timeout          = 60
}


resource "aws_lambda_function_url" "lambda_url" {
  for_each = aws_lambda_function.kopilka_api
  function_name      = each.value.function_name
  authorization_type = "NONE"

  cors {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = ["GET"]
    allow_headers     = ["date", "keep-alive"]
    expose_headers    = ["keep-alive", "date"]
    max_age           = 86400
  }
}
