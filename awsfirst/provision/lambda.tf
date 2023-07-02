resource "aws_iam_policy" "awsteam_lambda_policy" {
  name        = "awsteam-lambda"
  path        = "/"
  description = "Provides DynamoDB access to the AWSTeam table"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "dynamodb:BatchGetItem",
                "dynamodb:BatchWriteItem",
                "dynamodb:PutItem",
                "dynamodb:DeleteItem",
                "dynamodb:GetItem",
                "dynamodb:UpdateItem",
                "dynamodb:Scan"
            ],
            "Resource": "${aws_dynamodb_table.awsfirst-dynamodb.arn}"
        }
    ]
  })
}

data "aws_iam_policy_document" "lambda_trust_policy" {
  statement {
    actions    = ["sts:AssumeRole"]
    effect     = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "awsteam_lambda_role" {
  name               = "awsTeamLambdaRole"
  assume_role_policy = data.aws_iam_policy_document.lambda_trust_policy.json
}

resource "aws_iam_role_policy_attachment" "awsteam_lambda_execution_policy" {
  role       = aws_iam_role.awsteam_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "aws_team_dynamodb_policy" {
  role       = aws_iam_role.awsteam_lambda_role.name
  policy_arn = aws_iam_policy.awsteam_lambda_policy.arn
}

data "archive_file" "lambda_filename" {
  type        = "zip"
  source_dir  = "../backend/lambda/"
  output_path = "${path.module}/lambda_function_payload.zip"
}

resource "aws_lambda_function" "awsfirst_lambda" {
  depends_on = [ data.archive_file.lambda_filename ]
  function_name = var.lambda_name
  role          = aws_iam_role.awsteam_lambda_role.arn
  filename = data.archive_file.lambda_filename.output_path
  handler = "index.handler"
  runtime = "nodejs18.x"
}