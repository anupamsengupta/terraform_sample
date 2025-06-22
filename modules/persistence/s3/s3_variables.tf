
variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "allow_public_access" {
  description = "Whether to allow public access to the bucket"
  type        = bool
}

variable "enable_version" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
}
variable "sqs_queue_arn" {
  description = "ARN of the SQS queue to receive notifications"
  type        = string
}

variable "sqs_queue_url" {
  description = "URL of the SQS queue to receive notifications"
  type        = string
}

variable "notification_type" {
  description = "Type of notification: 'none', 'eventbridge', or 'sqs'"
  type        = string
  default     = "none"
  validation {
    condition     = contains(["none", "eventbridge", "sqs"], var.notification_type)
    error_message = "notification_type must be one of 'none', 'eventbridge', or 'sqs'."
  }
}

variable "filter_prefix" {
  description = "Prefix filter for S3 events"
  type        = string
  default     = ""
}

variable "filter_suffix" {
  description = "Suffix filter for S3 events"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Default tags to apply to all resources"
  type        = map(string)
  default     = {}
}