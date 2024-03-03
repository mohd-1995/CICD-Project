
terraform {
  backend "s3" {
    bucket = "moes-codepipeline-bucket"
    key = "testing2"
    region = "eu-west-2"
  }
}