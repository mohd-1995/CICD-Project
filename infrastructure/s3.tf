resource "aws_s3_bucket" "codacy-result" {
  bucket = "codacy-analysis-result-bucket"
  force_destroy = true
  tags = {
    Name = "Codacy-S3"
  }
}


resource "aws_s3_object" "code-obj" {
  bucket = aws_s3_bucket.codacy-result.id
  key = "tfstate-log"
  source = "terraform.tfstate"
}




