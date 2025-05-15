variable "vpc_cidr_block" {
  type = string                     # The type of the variable, in this case a string
  description = "The type of EC2 instance" # Description of what this variable represents
}
variable "enable_dns_hostnames" {
  default = true
}
variable "common_tags" {}
variable "vpc_tags" {
  default = {}
}
variable "project_name" {

}
variable "environment" {

}
variable "application" {

}