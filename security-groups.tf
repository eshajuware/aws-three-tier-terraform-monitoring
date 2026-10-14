resource "aws_security_group" "alb-security-group" {
  name        = "alb-security-group"
  description = "Security group for ALB"
  vpc_id      = aws_vpc.vpc_01.id  # Updated to your VPC resource name

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "webserver-security-group" {
  name        = "webserver-security-group"
  description = "Security group for web servers"
  vpc_id      = aws_vpc.vpc_01.id  # Updated to your VPC resource name

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb-security-group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ssh-security-group" {
  name        = "ssh-security-group"
  description = "Allow SSH access"
  vpc_id      = aws_vpc.vpc_01.id  # Updated to your VPC resource name

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["103.221.73.63/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "database-security-group" {
  name        = "database-security-group"
  description = "Security group for RDS database"
  vpc_id      = aws_vpc.vpc_01.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.webserver-security-group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

