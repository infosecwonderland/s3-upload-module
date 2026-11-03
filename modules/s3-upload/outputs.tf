output "object_keys" {
  description = "Full S3 keys of the uploaded objects."
  value       = [for obj in aws_s3_object.this : obj.key]
}

output "object_etags" {
  description = "ETag of each uploaded object, keyed by S3 key."
  value       = { for k, obj in aws_s3_object.this : obj.key => obj.etag }
}
