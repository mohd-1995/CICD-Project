provider "aws" {
  profile = "creating-dev"
}

terraform {
  backend "s3" {
    bucket = "codacy-analysis-result-bucket"
    key = "testing2.pem"
    region = "eu-west-2"
  }
}