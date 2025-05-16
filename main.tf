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

resource "aws_subnet" "public-subnets" {
  count = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = local.az_names[count.index]
  map_public_ip_on_launch = true
  tags = merge(var.common_tags, var.public_subnet_tags,
    { Name = "${local.resource_name}-public-${local.az_names[count.index]}" })
}

resource "aws_subnet" "private-subnets" {
  count = length(var.private_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_cidrs[count.index]
  availability_zone       = local.az_names[count.index]
  map_public_ip_on_launch = true
  tags = merge(var.common_tags, var.private_subnet_tags,
    { Name = "${local.resource_name}-private-${local.az_names[count.index]}" })
}

resource "aws_subnet" "database-subnets" {
  count = length(var.database_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.database_subnet_cidrs[count.index]
  availability_zone       = local.az_names[count.index]
  map_public_ip_on_launch = true
  tags = merge(var.common_tags, var.database_subnet_tags,
    { Name = "${local.resource_name}-database-${local.az_names[count.index]}" })
}


resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.common_tags,
    {
      Name = "${local.resource_name}-public-route-table"

    })
}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.common_tags,
    {
      Name = "${local.resource_name}-private-route-table"

    })
}

resource "aws_route" "public-route" {
  route_table_id         = aws_route_table.public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public-subnets[count.index].id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private-subnets[count.index].id
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_eip" "eip" {
  domain = "vpc"
  tags = merge(var.common_tags,
    {
      Name = "${local.resource_name}-eip"

    })
}

resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public-subnets[0].id

  tags = merge(
    var.common_tags,
    {
      Name = local.resource_name
    }
  )
}