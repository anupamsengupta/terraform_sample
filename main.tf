# Example usage of the network module
provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = var.default_tags
  }
}

module "network" {
  source               = "./modules/network"
  vpc_cidr             = var.vpc_cidr
  vpc_name             = var.vpc_name
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  subnet_count         = var.subnet_count
}

module "upload_notification_queue" {
  source        = "./modules/persistence/queue"
  # This queue is used for S3 notifications
  queue_name    = var.queue_name
  do_attach_dlq = true

}

module "upload_notification_queue_eventbridge" {
  source = "./modules/persistence/queue"
  # This queue is used for EventBridge notifications
  queue_name    = var.queue_name_eventbridge
  do_attach_dlq = true

}

module "s3" {
  source              = "./modules/persistence/s3"
  depends_on = [module.upload_notification_queue]
  # This bucket is used for S3 notifications
  bucket_name         = var.upload_bucket_name
  enable_version      = var.enable_version
  allow_public_access = var.allow_public_access
  # none or sqs or eventbridge
  notification_type   = "sqs" 
  sqs_queue_arn       = module.upload_notification_queue.queue_arn
  filter_prefix       = "uploads/" 
  filter_suffix       = ".jpg"
  sqs_queue_url       = module.upload_notification_queue.queue_url
}

module "s3_eventbridge" {
  source     = "./modules/persistence/s3"
  depends_on = [module.upload_notification_queue_eventbridge]
  # This bucket is used for EventBridge notifications
  bucket_name         = var.upload_bucket_name_eventbridge
  enable_version      = var.enable_version
  allow_public_access = var.allow_public_access
  # none or sqs or eventbridge
  notification_type = "eventbridge"
  sqs_queue_arn     = module.upload_notification_queue_eventbridge.queue_arn
  filter_prefix     = "uploads/"
  filter_suffix     = ".jpg"
  sqs_queue_url     = module.upload_notification_queue_eventbridge.queue_url
}