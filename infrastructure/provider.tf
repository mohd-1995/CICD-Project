provider "aws" {
  profile = "creating-dev"
}

terraform {
  backend "s3" {
    bucket = "moes-codepipeline-bucket"
    key = "testing2.pem"
    region = "eu-west-2"
  }
}