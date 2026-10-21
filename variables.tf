variable "aws_region" {
  description = "AWS region where the infrastructure is deployed."
  type        = string
}

variable "project_id" {
  description = "Project identifier used for tags and resource names."
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

variable "ssh_security_group_name" {
  description = "Name of the SSH security group."
  type        = string
}

variable "public_http_security_group_name" {
  description = "Name of the public HTTP security group."
  type        = string
}

variable "private_http_security_group_name" {
  description = "Name of the private HTTP security group."
  type        = string
}

variable "allowed_ip_range" {
  description = "CIDR ranges allowed to access SSH and public HTTP."
  type        = list(string)
}

variable "ssh_port" {
  description = "Port used for SSH access."
  type        = number
}

variable "http_port" {
  description = "Port used for HTTP traffic."
  type        = number
}

variable "launch_template_name" {
  description = "Name of the EC2 launch template."
  type        = string
}

variable "autoscaling_group_name" {
  description = "Name of the Auto Scaling group."
  type        = string
}

variable "load_balancer_name" {
  description = "Name of the Application Load Balancer."
  type        = string
}

variable "target_group_name" {
  description = "Name of the ALB target group."
  type        = string
}

variable "instance_name" {
  description = "Name tag assigned to application instances."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type used by the application."
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of instances in the Auto Scaling group."
  type        = number
}

variable "min_size" {
  description = "Minimum number of instances in the Auto Scaling group."
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances in the Auto Scaling group."
  type        = number
}

variable "ami_name_regex" {
  description = "Regular expression used to locate the Amazon Linux AMI."
  type        = string
}

variable "ami_owners" {
  description = "Trusted owners of the EC2 AMI."
  type        = list(string)
}
