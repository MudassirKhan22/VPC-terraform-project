resource "aws_s3_bucket" "new_bucket" {
  bucket = var.S3
  tags = {
    Name = "New S3 Bucket"
  }
}

resource "aws_s3_bucket_versioning" "new_bucket_versioning" {
  bucket = aws_s3_bucket.new_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# resource "aws_s3_bucket" "new_bucket" {
#     bucket = "mudassir-bucket-name-12345"
#     tags = {
#       Name = "New S3 Bucket"
#     }
# }