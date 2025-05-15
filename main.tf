terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
  }
}
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  instance_tenancy     = "default"
  tags = merge(var.common_tags, var.vpc_tags,
    { Name = local.resource_name })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = merge(var.common_tags, var.igw_tags,
    { Name = local.resource_name })
}
resource "random_shuffle" "az" {
  input        = data.aws_availability_zones.aws_avail_zones
  result_count = 1
}
resource "aws_subnet" "public-subnets" {
  count = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = random_shuffle.az.result
  map_public_ip_on_launch = true
  tags = merge(var.common_tags, var.public_subnet_tags,
    { Name = "${local.resource_name}-public-${random_shuffle.az.result}" })
}

resource "aws_subnet" "private-subnets" {
  count = length(var.private_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_cidrs[count.index]
  availability_zone       = random_shuffle.az.result
  map_public_ip_on_launch = true
  tags = merge(var.common_tags, var.private_subnet_tags,
    { Name = "${local.resource_name}-public-${random_shuffle.az.result}" })
}

resource "aws_subnet" "database-subnets" {
  count = length(var.database_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.database_subnet_cidrs[count.index]
  availability_zone       = random_shuffle.az.result
  map_public_ip_on_launch = true
  tags = merge(var.common_tags, var.database_subnet_tags,
    { Name = "${local.resource_name}-public-${random_shuffle.az.result}" })
}


