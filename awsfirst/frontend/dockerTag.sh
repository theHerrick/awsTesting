aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin 941603547826.dkr.ecr.eu-west-2.amazonaws.com

docker tag awsfirst 941603547826.dkr.ecr.eu-west-2.amazonaws.com/awsfirst:latest