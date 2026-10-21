data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = var.ami_owners
  name_regex  = var.ami_name_regex
}


resource "aws_launch_template" "application" {
  name          = var.launch_template_name
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true

    security_groups = [
      var.ssh_security_group_id,
      var.private_http_security_group_id
    ]
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    dnf install -y httpd

    TOKEN=$(curl -sS -X PUT \
      -H "X-aws-ec2-metadata-token-ttl-seconds: 21600" \
      http://169.254.169.254/latest/api/token)

    INSTANCE_ID=$(curl -sS \
      -H "X-aws-ec2-metadata-token: $TOKEN" \
      http://169.254.169.254/latest/meta-data/instance-id)

    PRIVATE_IP=$(curl -sS \
      -H "X-aws-ec2-metadata-token: $TOKEN" \
      http://169.254.169.254/latest/meta-data/local-ipv4)
    
    INSTANCE_UUID=$(cat /proc/sys/kernel/random/uuid)
    
    cat > /var/www/html/index.html <<HTML
    <html>
      <body>
        <h1>Application Instance</h1>
        <p>UUID: $INSTANCE_UUID</p>
        <p>Instance ID: $INSTANCE_ID</p>
        <p>Private IP: $PRIVATE_IP</p>
      </body>
    </html>
    HTML

    systemctl enable httpd
    systemctl start httpd
  EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name      = var.instance_name
      Project   = var.project_id
      Terraform = "true"
    }
  }

  tags = {
    Name      = var.launch_template_name
    Project   = var.project_id
    Terraform = "true"
  }
}


resource "aws_lb_target_group" "application" {
  name                          = var.target_group_name
  port                          = var.http_port
  protocol                      = "HTTP"
  vpc_id                        = var.vpc_id
  load_balancing_algorithm_type = "round_robin"

  health_check {
    enabled             = true
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }

  tags = {
    Name      = var.target_group_name
    Project   = var.project_id
    Terraform = "true"
  }
}


resource "aws_lb" "application" {
  name               = var.load_balancer_name
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    var.public_http_security_group_id
  ]

  subnets = var.subnet_ids

  tags = {
    Name      = var.load_balancer_name
    Project   = var.project_id
    Terraform = "true"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.application.arn
  port              = var.http_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.application.arn
  }
}


resource "aws_autoscaling_group" "application" {
  name = var.autoscaling_group_name

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  vpc_zone_identifier = var.subnet_ids

  health_check_type         = "ELB"
  health_check_grace_period = 180

  launch_template {
    id      = aws_launch_template.application.id
    version = aws_launch_template.application.latest_version
  }

  instance_refresh {
    strategy = "Rolling"

    preferences {
      min_healthy_percentage = 50
    }
  }

  tag {
    key                 = "Name"
    value               = var.instance_name
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = var.project_id
    propagate_at_launch = true
  }

  tag {
    key                 = "Terraform"
    value               = "true"
    propagate_at_launch = true
  }

  lifecycle {
    ignore_changes = [
      load_balancers,
      target_group_arns
    ]
  }
}


resource "aws_autoscaling_attachment" "application" {
  autoscaling_group_name = aws_autoscaling_group.application.id
  lb_target_group_arn    = aws_lb_target_group.application.arn
}
