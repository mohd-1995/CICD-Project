provider "aws" {
  profile = "creating-dev"
  access_key = "AKIA5KF625Q4T6E6NAGI"
  secret_key = "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"
}

terraform {
  backend "s3" {
    bucket = "moes-codepipeline-bucket"
    key = "testing2"
    region = "eu-west-2"
  }
}