resource "aws_dynamodb_table" "awsfirst-dynamodb" {
  name           = var.dynamodb_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "ID"

  attribute {
        name = "ID"
        type = "S"
    }

  tags = {
    app_identifier = var.app_identifier
    Environment    = var.environment
  }
}