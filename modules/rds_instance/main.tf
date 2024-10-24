# Define the RDS instance 
resource "aws_db_instance" "this"{
  allocated_storage = var.allocated_storage
  engine = var.engine
#  engine_version = var.engine_version
  instance_class = var.instance_class
  db_name = var.db_name
  username = var.username
  password = var.password
  db_subnet_group_name = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.security_group_ids
  skip_final_snapshot = var.skip_final_snapshot

  tags = {
    Name = var.db_instance_name
  }
}

#Define the DB Subnet Group
resource "aws_db_subnet_group" "this"{
  name = var.subnet_group_name
  subnet_ids = var.subnet_ids

  tags = {
    Name = var.subnet_group_name
  }
}
