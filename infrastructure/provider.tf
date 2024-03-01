provider "aws" {
  profile = "creating-dev"
}

terraform {
  backend "s3" {
    bucket = "webhost-myaws"
    key = "testing2.pem"
    region = "eu-west-2"
  }
}