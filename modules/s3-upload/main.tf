terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

locals {
  content_types = {
    html = "text/html"
    css  = "text/css"
    js   = "application/javascript"
    json = "application/json"
    txt  = "text/plain"
    csv  = "text/csv"
    svg  = "image/svg+xml"
    png  = "image/png"
    jpg  = "image/jpeg"
    jpeg = "image/jpeg"
    gif  = "image/gif"
    pdf  = "application/pdf"
    zip  = "application/zip"
  }
}

resource "aws_s3_object" "this" {
  for_each = var.files

  bucket      = var.bucket_name
  key         = "${var.key_prefix}${each.key}"
  source      = each.value
  source_hash = filemd5(each.value)

  content_type = lookup(
    local.content_types,
    lower(reverse(split(".", each.key))[0]),
    "application/octet-stream",
  )

  kms_key_id = var.kms_key_arn
  tags       = var.tags
}
