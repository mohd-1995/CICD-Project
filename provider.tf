provider "aws" {
  profile = "creating-dev"
  region = "eu-west-2"
}

terraform {
  backend "s3" {
    bucket = "moes-codepipeline-bucket"
    key = "testing2"
    region = "eu-west-2"
  }
}