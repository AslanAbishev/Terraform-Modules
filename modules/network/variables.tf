variable "project_id" {
  description = "Project identifier used for resource tags."
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC."
  type        = string
}

variable "public_subnets" {
  description = "Configuration of the public subnets."
  type = map(object({
    name              = string
    cidr_block        = string
    availability_zone = string
  }))
}

variable "internet_gateway_name" {
  description = "Name of the Internet Gateway."
  type        = string
}

variable "route_table_name" {
  description = "Name of the public route table."
  type        = string
}

variable "default_route_cidr" {
  description = "CIDR block used for the default Internet route."
  type        = string
}
