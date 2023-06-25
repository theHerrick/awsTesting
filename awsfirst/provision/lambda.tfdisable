data "archive_file" "lambda_filename" {
    type = "zip"
    output_path = "${path.module}/lambda_function_payload.zip"

    source {
      content = "lambda_deploy"
      filename = "deploy.txt"
    }
}

resource "aws_lambda_function" "awsfirst_lambda" {
  function_name = var.lambda_name
  role          = "arn:aws:iam::941603547826:role/service-role/testApi-role-p5qt19gi"
  filename = data.archive_file.lambda_filename.output_path
  handler = "index.test"
  runtime = "nodejs16.x"

  tags = {
    app_identifier = var.app_identifier
    Environment    = var.environment
  }
}