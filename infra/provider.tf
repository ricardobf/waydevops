provider "aws" {
  version = "3.7.0"
  region = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}