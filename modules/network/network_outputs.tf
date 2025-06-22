# network/outputs.tf
output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnet[*].id
}

output "ssh_sg_id" {
  value = aws_security_group.ssh.id
}

output "http_sg_id" {
  value = aws_security_group.http.id
}

output "https_sg_id" {
  value = aws_security_group.https.id
}

output "rds_postgres_sg_id" {
  value = aws_security_group.rds_postgres.id
}

output "ssh_sg" {
  value = aws_security_group.ssh
}

output "http_sg" {
  value = aws_security_group.http
}

output "https_sg" {
  value = aws_security_group.https
}

output "rds_postgres_sg" {
  value = aws_security_group.rds_postgres
}

