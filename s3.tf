# Generate a unique suffix for the S3 bucket name
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# Private S3 bucket
resource "aws_s3_bucket" "secure_storage" {
  bucket = "secure-app-storage-${random_id.bucket_suffix.hex}"

  tags = {
    Name        = "secure-app-storage"
    Environment = "learning"
    ManagedBy   = "Terraform"
  }
}

# Enable bucket versioning
resource "aws_s3_bucket_versioning" "secure_storage" {
  bucket = aws_s3_bucket.secure_storage.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "secure_storage" {
  bucket = aws_s3_bucket.secure_storage.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block all public access
resource "aws_s3_bucket_public_access_block" "secure_storage" {
  bucket = aws_s3_bucket.secure_storage.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

output "secure_s3_bucket_name" {
  description = "Name of the private application storage bucket"
  value       = aws_s3_bucket.secure_storage.bucket
}
