terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  description = "AWS region of the bucket."
  type        = string
  default     = "ap-southeast-1"
}

variable "bucket_name" {
  description = "Existing bucket to upload into."
  type        = string
}

# Uploads everything under ./upload/ and keeps its relative paths as keys.
module "s3_upload" {
  source = "../../modules/s3-upload"

  bucket_name = var.bucket_name
  key_prefix  = "demo/"

  files = {
    for f in fileset("${path.module}/upload", "**") :
    f => "${path.module}/upload/${f}"
  }
}

output "uploaded_keys" {
  value = module.s3_upload.object_keys
}
