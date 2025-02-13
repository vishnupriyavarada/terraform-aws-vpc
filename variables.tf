//----------- common variables ---------------------------------------

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

variable "vpc_tags" {
    type = map  
    default = {}   
}

variable "igw_tags" {
    type = map
    default = {}       
}

//------------ vpc variables --------------------------------------------
# when variable left empty it's mandatory
variable "vpc_cidr" {
    type = string
}
variable "enable_dns_hostnames" {
    type = bool
    default = true
}   

//------------ public subnet variables -----------------------------------------
variable "public_subnet_cidr" {  
  type = list(string)
  validation {
    condition = length(var.public_subnet_cidr) == 2
    error_message = "Please provide 2 valid CIDR"
  }
}

variable "public_subnet_tags" {
  default = {}
}

//------------ private subnet variables -----------------------------------------
variable "private_subnet_cidr" {  
  type = list(string)
  validation {
    condition = length(var.private_subnet_cidr) == 2
    error_message = "Please provide 2 valid CIDR"
  }
}

variable "private_subnet_tags" {
  default = {}
}

//------------ database subnet variables -----------------------------------------
variable "database_subnet_cidr" {  
  type = list(string)
  validation {
    condition = length(var.database_subnet_cidr) == 2
    error_message = "Please provide 2 valid CIDR"
  }
}

variable "database_subnet_tags" {
  default = {}
}