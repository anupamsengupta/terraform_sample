variable "application_name" {
  description = "The name of the application"
  type        = string
  default     = "cloud_sample1"
}

variable "environment" {
  description = "The deployment environment (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "default_tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default = {
    Environment = "TEST"
    Project     = "CloudSample1"
    ManagedBy   = "Terraform"
    Ticket      = "ICRQ-1884"
  }
}

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "azs" {
  description = "A list of availability zones for the VPC"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
  default     = "main-vpc"
}
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.101.0.0/16"
}
variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}
variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}
variable "subnet_count" {
  description = "Number of subnets to create in each availability zone"
  type        = number
  default     = 2
}
variable "upload_bucket_name" {
  description = "Name of the S3 bucket for uploads"
  type        = string
  default     = "com-quickysoft-anu-cloudsample1-uploads"
}
variable "allow_public_access" {
  description = "Whether to allow public access to the bucket"
  type        = bool
  default     = false
}
variable "enable_version" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = true
}
variable "queue_name" {
  description = "Name tag for the VPC"
  type        = string
  default     = "cloudsample1-upload-notification-queue"
}
variable "do_attach_dlq" {
  description = "Flag to attach a dead-letter queue to the SQS queue"
  type        = bool
  default     = false
}

