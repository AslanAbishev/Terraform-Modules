variable "project_id" {
  description = "Project identifier used for resource tags."
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC."
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs used by the Auto Scaling group and load balancer."
  type        = list(string)
}

variable "ssh_security_group_id" {
  description = "ID of the SSH security group."
  type        = string
}

variable "private_http_security_group_id" {
  description = "ID of the private HTTP security group."
  type        = string
}

variable "public_http_security_group_id" {
  description = "ID of the public HTTP security group used by the load balancer."
  type        = string
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
  description = "Name of the Application Load Balancer target group."
  type        = string
}

variable "instance_name" {
  description = "Name tag assigned to EC2 instances."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of application instances."
  type        = number
}

variable "min_size" {
  description = "Minimum number of instances."
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances."
  type        = number
}

variable "http_port" {
  description = "HTTP port used by the application and load balancer."
  type        = number
}

variable "ami_name_regex" {
  description = "Regular expression used to locate the Amazon Linux AMI."
  type        = string
}

variable "ami_owners" {
  description = "Trusted AMI owners."
  type        = list(string)
}
