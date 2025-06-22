# network/variables.tf
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}
variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}
variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
}
variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
}
variable "subnet_count" {
  description = "Number of subnets to create in each availability zone"
  type        = number
}