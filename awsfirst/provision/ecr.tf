resource "aws_ecr_repository" "awsfirst_ecr" {
  name                 = var.ecr_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  force_delete = true
}
resource "null_resource" "ecr_image" {
  depends_on = [aws_ecr_repository.awsfirst_ecr]
  provisioner "local-exec" {
    interpreter = ["/bin/bash" ,"-c"]
    command = "aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin 941603547826.dkr.ecr.eu-west-2.amazonaws.com && docker push ${aws_ecr_repository.awsfirst_ecr.repository_url}:latest"
  }
}

