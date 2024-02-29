provider "aws" {
  profile = "creating-dev"
  region  = "eu-west-2"
}


terraform {
  backend "s3" {
    bucket = "codacy-analysis-result-bucket"
    key = "test2.pem"
    region = "eu-west-2"
  }
}