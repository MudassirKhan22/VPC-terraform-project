resource "aws_s3_bucket" "new_bucket" {
    bucket = "mudassir-bucket-name-12345"
    tags = {
      Name = "New S3 Bucket"
    }
}