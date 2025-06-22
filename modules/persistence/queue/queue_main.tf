# modules/network/persistence/sqs/main.tf
resource "aws_sqs_queue" "dlq" {
  count                      = var.do_attach_dlq ? 1 : 0
  name                       = "${var.queue_name}-dlq"
  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.message_retention_seconds

  tags = merge(
    var.tags,
    {
      Name = "${var.queue_name}-dlq"
    }
  )
}

resource "aws_sqs_queue" "main" {
  name                       = "${var.queue_name}-queue"
  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.message_retention_seconds

  redrive_policy = var.do_attach_dlq ? jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq[0].arn
    maxReceiveCount     = var.max_receive_count
  }) : null

  tags = merge(
    var.tags,
    {
      Name = "${var.queue_name}-queue"
    }
  )
}

