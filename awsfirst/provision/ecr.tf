resource "aws_ecr_repository" "awsfirst_ecr" {
  name                 = var.ecr_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    app_identifier = var.app_identifier
    Environment    = var.environment
  }
}