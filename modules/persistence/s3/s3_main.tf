# modules/persistence/s3/s3_main.tf
# This module creates an S3 bucket with optional public access, versioning, and event notifications
resource "aws_s3_bucket" "s3_bucket" {
  bucket        = var.bucket_name
  force_destroy = true
  tags = merge(
    var.tags,
    {
      Name = var.bucket_name
    }
  )
  versioning {
    enabled = var.enable_version
  }

  acl = var.allow_public_access ? "public-read" : "private"
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = !var.allow_public_access
  block_public_policy     = !var.allow_public_access
  ignore_public_acls      = !var.allow_public_access
  restrict_public_buckets = !var.allow_public_access
}

resource "aws_s3_bucket_notification" "sqs_notification" {
  count  = var.notification_type == "sqs" ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket.id

  queue {
    queue_arn     = var.sqs_queue_arn
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = var.filter_prefix
    filter_suffix = var.filter_suffix
  }

  depends_on = [aws_sqs_queue_policy.sqs_policy]
}

resource "aws_s3_bucket_notification" "eventbridge_notification" {
  count       = var.notification_type == "eventbridge" ? 1 : 0
  bucket      = aws_s3_bucket.s3_bucket.id
  eventbridge = true
}

resource "aws_cloudwatch_event_rule" "s3_event_rule" {
  count       = var.notification_type == "eventbridge" ? 1 : 0
  name        = "${var.bucket_name}-s3-event-rule"
  description = "Capture S3 events for ${var.bucket_name}"

  event_pattern = jsonencode({
    source      = ["aws.s3"]
    detail_type = ["Object Created"]
    detail = {
      bucket = {
        name = [var.bucket_name]
      }
      object = {
        key = [
          {
            prefix = var.filter_prefix
            suffix = var.filter_suffix
          }
        ]
      }
    }
  })

  tags = merge(
    var.tags,
    {
      Name = "${var.bucket_name}-s3-event-rule"
    }
  )
}

resource "aws_cloudwatch_event_target" "sqs_target" {
  count     = var.notification_type == "eventbridge" ? 1 : 0
  rule      = aws_cloudwatch_event_rule.s3_event_rule[0].name
  target_id = "${var.bucket_name}-sqs-target"
  arn       = var.sqs_queue_arn
}

resource "aws_sqs_queue_policy" "sqs_policy" {
  count     = var.notification_type != "none" ? 1 : 0
  queue_url = var.sqs_queue_url

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "sqs:SendMessage"
        Resource  = var.sqs_queue_arn
        Condition = {
          ArnEquals = {
            #"aws:SourceArn" = var.notification_type == "eventbridge" ? "arn:aws:events:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:rule/${aws_cloudwatch_event_rule.s3_event_rule[0].name}" : aws_s3_bucket.s3_bucket.arn
            "aws:SourceArn" = var.notification_type == "eventbridge" ? "arn:aws:events:${data.aws_region.current}:${data.aws_caller_identity.current.account_id}:rule/${aws_cloudwatch_event_rule.s3_event_rule[0].name}" : aws_s3_bucket.s3_bucket.arn
          }
        }
      }
    ]
  })
}
