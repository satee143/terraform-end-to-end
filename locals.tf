locals {
  resource_name="${var.project_name}-${var.environment}"
  az_names = slice(data.aws_availability_zones.aws_avail_zones.names, 0, 2)
}