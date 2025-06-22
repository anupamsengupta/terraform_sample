#Retrieve the list of AZs in the current AWS region

# Data source for availability zones
data "aws_availability_zones" "available" {
  state = "available"

}

data "aws_region" "current" {}
# Retrieve the current AWS account ID
data "aws_caller_identity" "current" {}
# Retrieve the current AWS account alias
data "aws_iam_account_alias" "current" {}
