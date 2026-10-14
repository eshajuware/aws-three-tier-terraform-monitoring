#########################################
#### ASG for Presentation Tier        ###
#########################################

resource "aws_launch_template" "auto-scaling-group" {
  name_prefix   = "auto-scaling-group"
  image_id      = "ami-052efd3df9dad4825"
  instance_type = "t2.micro"
  user_data     = base64encode(file("install-apache.sh"))
  key_name      = "project"

  network_interfaces {
    subnet_id       = aws_subnet.public-web-subnet-1.id
    security_groups = [aws_security_group.webserver-security-group.id]
  }
}

resource "aws_autoscaling_group" "asg-1" {
  availability_zones   = ["us-east-1a"]
  desired_capacity     = 1
  max_size             = 2
  min_size             = 1

  launch_template {
    id      = aws_launch_template.auto-scaling-group.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.alb_target_group.arn]
}

#########################################
#### ASG for Application Tier         ###
#########################################

resource "aws_launch_template" "auto-scaling-group-private" {
  name_prefix   = "auto-scaling-group-private"
  image_id      = "ami-052efd3df9dad4825"
  instance_type = "t2.micro"
  key_name      = "project"

  network_interfaces {
    subnet_id       = aws_subnet.private-app-subnet-1.id
    security_groups = [aws_security_group.ssh-security-group.id]
  }
}

resource "aws_autoscaling_group" "asg-2" {
  availability_zones = ["us-east-1a"]
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1

  launch_template {
    id      = aws_launch_template.auto-scaling-group-private.id
    version = "$Latest"
  }
}
