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

output "public-route-table_id" {
  value = aws_route_table.public-route-table.id
}
output "private-route-table_id" {
  value = aws_route_table.private-route-table.id
}
# output "database-route-table_id" {
#   value = aws_route_table.database-route-table.id
}
output "eip_id" {
  value = aws_eip.eip.id
}
output "eip_ip" {
  value = aws_eip.eip.public_ip
}
output "nat_gateway" {
  value = aws_nat_gateway.example.id
}



