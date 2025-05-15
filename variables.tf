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
variable "igw_tags" {
  default = {}
}

variable "public_subnet_tags" {
  default = {}
}
variable "private_subnet_tags" {
  default = {}
}
variable "database_subnet_tags" {
  default = {}
}

variable "project_name" {

}
variable "environment" {

}
variable "application" {
  default = ""

}

variable "public_subnet_cidrs" {
  type = list(string)                     # The type of the variable, in this case a string
  description = "The type of EC2 instance" # Description of what this variable represents
}

variable "private_subnet_cidrs" {
  type = list(string)                     # The type of the variable, in this case a string
  description = "The type of EC2 instance" # Description of what this variable represents
}


variable "database_subnet_cidrs" {
  type = list(string)                     # The type of the variable, in this case a string
  description = "The type of EC2 instance" # Description of what this variable represents
}

