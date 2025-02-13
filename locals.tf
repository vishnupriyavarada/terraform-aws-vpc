locals {
  resource_name = "${var.projectname}-${var.environment}"
  az_names = slice(data.aws_availability_zones.available.names, 0, 2)
}