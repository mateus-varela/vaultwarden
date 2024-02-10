provider "aws" {

  default_tags {
    tags = {
      owner      = "Mateus Varela"
      managed-by = "terraform"
    }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      #version = "~> 3.0"
    }
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket
}

resource "aws_s3_bucket_ownership_controls" "bucket-ownership" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "bucket-acl" {
  depends_on = [aws_s3_bucket_ownership_controls.bucket-ownership]

  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "bucket-versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}