//This module is created for general. not pertaining to one project. so give generic names
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  // In a server we can host multiple hosts. instance_tenancy allows it
  instance_tenancy = "default"
 # tags convention. projectname-environment
  tags = merge(
    var.common_tags, 
    {
        Name = local.resource_name
    }
  )
}