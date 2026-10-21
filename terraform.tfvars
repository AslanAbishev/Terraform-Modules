aws_region = "eu-west-1"
project_id = "cmtr-7fdui0mc"

vpc_name = "cmtr-7fdui0mc-vpc"
vpc_cidr = "10.10.0.0/16"

public_subnets = {
  a = {
    name              = "cmtr-7fdui0mc-subnet-public-a"
    cidr_block        = "10.10.1.0/24"
    availability_zone = "eu-west-1a"
  }

  b = {
    name              = "cmtr-7fdui0mc-subnet-public-b"
    cidr_block        = "10.10.3.0/24"
    availability_zone = "eu-west-1b"
  }

  c = {
    name              = "cmtr-7fdui0mc-subnet-public-c"
    cidr_block        = "10.10.5.0/24"
    availability_zone = "eu-west-1c"
  }
}

internet_gateway_name = "cmtr-7fdui0mc-igw"
route_table_name      = "cmtr-7fdui0mc-rt"
default_route_cidr    = "0.0.0.0/0"

ssh_security_group_name          = "cmtr-7fdui0mc-ssh-sg"
public_http_security_group_name  = "cmtr-7fdui0mc-public-http-sg"
private_http_security_group_name = "cmtr-7fdui0mc-private-http-sg"

allowed_ip_range = [
  "18.153.146.156/32",
  "176.98.224.123/32"
]

ssh_port  = 22
http_port = 80

launch_template_name   = "cmtr-7fdui0mc-template"
autoscaling_group_name = "cmtr-7fdui0mc-asg"
load_balancer_name     = "cmtr-7fdui0mc-lb"
target_group_name      = "cmtr-7fdui0mc-tg"
instance_name          = "cmtr-7fdui0mc-instance"

instance_type = "t3.micro"

desired_capacity = 2
min_size         = 2
max_size         = 2

ami_name_regex = "^al2023-ami-2023.*-x86_64$"
ami_owners     = ["amazon"]
