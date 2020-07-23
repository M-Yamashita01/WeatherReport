provider "aws" {
  access_key = "$AWS_ACCESS_KEY_ID"
  secret_key = "$AWS_SECRET_ACCESS_KEY"
  region = "ap-northeast-1"
}

terraform {
  backend "s3" {
    access_key = "$AWS_ACCESS_KEY_ID"
    secret_key = "$AWS_SECRET_ACCESS_KEY"
    bucket  = "$AWS_BUCKET"
    key     = "terraform.tfstate"
    region  = "ap-northeast-1"
    encrypt = true
  }
}