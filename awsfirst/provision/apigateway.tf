resource "aws_api_gateway_rest_api" "apigateway" {
  name = var.api_name

    tags = {
    app_identifier = var.app_identifier
    Environment    = var.environment
  }

}

resource "aws_api_gateway_resource" "apipath" {
  parent_id   = aws_api_gateway_rest_api.apigateway.root_resource_id
  path_part   = "table"
  rest_api_id = aws_api_gateway_rest_api.apigateway.id
}

resource "aws_api_gateway_method" "getmethod" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.apipath.id
  rest_api_id   = aws_api_gateway_rest_api.apigateway.id
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.apigateway.id
  resource_id             = aws_api_gateway_resource.apipath.id
  http_method             = aws_api_gateway_method.getmethod.http_method
  integration_http_method = "GET"
  type                    = "AWS"
  uri                     = aws_lambda_function.awsfirst_lambda.invoke_arn
}