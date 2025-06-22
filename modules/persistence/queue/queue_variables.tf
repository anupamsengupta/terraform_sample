# modules/network/persistence/sqs/variables.tf
variable "queue_name" {
  description = "Name of the SQS queue"
  type        = string
  default     = "main-queue"
}

variable "do_attach_dlq" {
  description = "Whether to attach a Dead Letter Queue"
  type        = bool
  default     = false
}

variable "visibility_timeout_seconds" {
  description = "The visibility timeout for the queue in seconds"
  type        = number
  default     = 30
}

variable "message_retention_seconds" {
  description = "The number of seconds to retain a message"
  type        = number
  default     = 345600 # 4 days
}

variable "max_receive_count" {
  description = "The maximum number of times a message is delivered before being moved to the DLQ"
  type        = number
  default     = 5
}

variable "tags" {
  description = "Default tags to apply to all resources"
  type        = map(string)
  default     = {}
}