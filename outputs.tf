output "vpc_id" {
  value = aws_vpc.main.id                                          # The actual value to be outputted
  description = "VPC ID" # Description of what this output represents
}

output "public_subnet_ids" {
  value = aws_subnet.public-subnets[*].id
}
output "private_subnet_ids" {
  value = aws_subnet.private-subnets[*].id
}

output "database_subnet_ids" {
  value = aws_subnet.database-subnets[*].id
}


