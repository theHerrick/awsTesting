resource "aws_dynamodb_table" "awsfirst-dynamodb" {
  name           = var.dynamodb_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "ID"

  attribute {
        name = "ID"
        type = "S"
    }
}

resource "aws_dynamodb_table_item" "first-item" {
  table_name = aws_dynamodb_table.awsfirst-dynamodb.name
  hash_key   = aws_dynamodb_table.awsfirst-dynamodb.hash_key

  item = <<ITEM
{
  "ID": {"S": "1"},
  "title": {"S": "First Card"},
  "description": {"S": "This is the description for the first card. This item is generated via Terraform during deployment."}
}
ITEM
}

resource "aws_dynamodb_table_item" "second-item" {
  table_name = aws_dynamodb_table.awsfirst-dynamodb.name
  hash_key   = aws_dynamodb_table.awsfirst-dynamodb.hash_key

  item = <<ITEM
{
  "ID": {"S": "2"},
  "title": {"S": "Second Card"},
  "description": {"S": "This is the description for the second card. This item is generated via Terraform during deployment."}
}
ITEM
}

resource "aws_dynamodb_table_item" "third-item" {
  table_name = aws_dynamodb_table.awsfirst-dynamodb.name
  hash_key   = aws_dynamodb_table.awsfirst-dynamodb.hash_key

  item = <<ITEM
{
  "ID": {"S": "3"},
  "title": {"S": "Third Card"},
  "description": {"S": "This is the description for the third card. This item is generated via Terraform during deployment."}
}
ITEM
}