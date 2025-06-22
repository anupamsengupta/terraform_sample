# Output the VPC, Subnet, and Security Group IDs
output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnet_ids" {
  value = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.network.private_subnet_ids
}

output "security_group_ids" {
  value = {
    ssh          = module.network.ssh_sg_id
    http         = module.network.http_sg_id
    https        = module.network.https_sg_id
    rds_postgres = module.network.rds_postgres_sg_id
  }
}

output "queue_id" {
  value = module.upload_notification_queue.queue_id
}
output "queue_arn" {
  value = module.upload_notification_queue.queue_arn
}
output "dlq_id" {
  value = module.upload_notification_queue.dlq_id
}
output "dlq_arn" {
  value = module.upload_notification_queue.dlq_arn
}
output "queue_id_eventbridge" {
  value = module.upload_notification_queue_eventbridge.queue_id
}
output "queue_arn_eventbridge" {
  value = module.upload_notification_queue_eventbridge.queue_arn
}
output "dlq_id_eventbridge" {
  value = module.upload_notification_queue_eventbridge.dlq_id
}
output "dlq_arn_eventbridge" {
  value = module.upload_notification_queue_eventbridge.dlq_arn
}
output "s3_bucket_name" {
  value = module.s3.s3_bucket_name
}
output "s3_bucket_arn" {
  value = module.s3.s3_bucket_arn
}

