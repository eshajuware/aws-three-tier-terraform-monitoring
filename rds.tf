###############################
#### database subnet group ####
###############################

resource "aws_db_subnet_group" "database-subnet-group" {
  name        = "database-subnets-01"   # Changed to unique name without spaces
  subnet_ids  = [aws_subnet.private-db-subnet-1.id, aws_subnet.private-db-subnet-2.id]
  description = "Subnet group for database instance"

  tags = {
    Name = "Database Subnets"
  }
}

#####################################
####     database instance       ####
#####################################

resource "aws_db_instance" "database-instance" {
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0.35"      
  instance_class         = "db.t3.micro" 
  db_name                = "sqldb"
  username               = "admin"
  password               = "StrongPassword123!"
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
  # availability_zone removed to allow multi-AZ deployment
  db_subnet_group_name   = aws_db_subnet_group.database-subnet-group.name
  multi_az               = var.multi-az-deployment
  vpc_security_group_ids = [aws_security_group.database-security-group.id]

  tags = {
    Name = "MySQL Database"
  }
}

