# queue/outputs.tf
output "queue_id" {
  value = aws_sqs_queue.main.id
}
output "queue_arn" {
  value = aws_sqs_queue.main.arn
}
output "queue_url" {
  value = aws_sqs_queue.main.url
}
output "queue" {
  value = aws_sqs_queue.main
}
output "dlq_id" {
  value = aws_sqs_queue.dlq[0].id
}
output "dlq_arn" {
  value = aws_sqs_queue.dlq[0].arn
}
output "dlq" {
  value = aws_sqs_queue.dlq
}
