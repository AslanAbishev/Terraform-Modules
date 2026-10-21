resource "aws_security_group" "ssh" {
  name        = var.ssh_security_group_name
  description = "Allow SSH access from approved IP ranges"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH access"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_range
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = var.ssh_security_group_name
    Project   = var.project_id
    Terraform = "true"
  }
}

resource "aws_security_group" "public_http" {
  name        = var.public_http_security_group_name
  description = "Allow HTTP access from approved IP ranges"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP access"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_range
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = var.public_http_security_group_name
    Project   = var.project_id
    Terraform = "true"
  }
}

resource "aws_security_group" "private_http" {
  name        = var.private_http_security_group_name
  description = "Allow HTTP access only from the public HTTP security group"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP access from load balancer"
    from_port       = var.http_port
    to_port         = var.http_port
    protocol        = "tcp"
    security_groups = [aws_security_group.public_http.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = var.private_http_security_group_name
    Project   = var.project_id
    Terraform = "true"
  }
}
