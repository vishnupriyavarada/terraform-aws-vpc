
# when variable left empty it's mandatory
variable "vpc_cidr" {
    type = string
}
variable "enable_dns_hostnames" {
    type = bool
    default = true
}   

# setting mandatory because this is my org standards
variable "projectname" {
  type = string
}

# setting mandatory because this is my org standards
variable "environment" {
    type = string  
}

# usually for comman tags, we give project name, environment and Is from Terraform or not
variable "common_tags" {
    type = map     
}
