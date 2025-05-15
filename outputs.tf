output "vpc_id" {
  value = aws_vpc.main.id                                          # The actual value to be outputted
  description = "VPC ID" # Description of what this output represents
}