resource "aws_apigatewayv2_api" "awsfirst-api" {
  name          = var.api_name
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "awsfirst-stage" {
  api_id = aws_apigatewayv2_api.awsfirst-api.id
  name   = "$default"
  auto_deploy = true
}


resource "aws_apigatewayv2_integration" "awsfirst-api-integration" {
  api_id = aws_apigatewayv2_api.awsfirst-api.id

  integration_uri    = aws_lambda_function.awsfirst_lambda.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_lambda_permission" "awsfirst-integration-permissons" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.awsfirst_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.awsfirst-api.execution_arn}/*/*"
}


resource "aws_apigatewayv2_route" "awsfirst-api-get-route" {
  api_id    = aws_apigatewayv2_api.awsfirst-api.id
  route_key = "GET /awsteam"

  target = "integrations/${aws_apigatewayv2_integration.awsfirst-api-integration.id}"
}