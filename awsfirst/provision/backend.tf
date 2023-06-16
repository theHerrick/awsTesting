terraform {
  backend "s3" {
    bucket         = "theherrickstate"
    key            = "awsfirst.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "theherrickstate"
  }
}
