variable "bucket_name" {
  description = "Name of the existing S3 bucket to upload into."
  type        = string
}

variable "files" {
  description = "Map of object key (relative to key_prefix) => local file path to upload."
  type        = map(string)
}

variable "key_prefix" {
  description = "Prefix added to every object key, e.g. \"releases/v1/\". Include the trailing slash."
  type        = string
  default     = ""
}

variable "kms_key_arn" {
  description = "KMS key ARN for SSE-KMS. Null leaves encryption to the bucket default."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags applied to each uploaded object."
  type        = map(string)
  default     = {}
}
