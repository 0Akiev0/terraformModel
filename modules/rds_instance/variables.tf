variable "allocated_storage" {
  description = "The amount of allocated storage in GBs" 
  default = 20
}

variable "engine"{
  description = "The database engine to use"
  default = "mysql"
}

variable "engine_version"{
  description = "The version of the database engine"
  default = "8.0.23"
}

variable "instance_class"{
  description = "The instance class to use for the RDS instance"
  default = "db.t3.micro"
}

variable "db_name"{
  description = "The name of the database to create"
  default = "mydatabase"
}

variable "username"{
  description = "The username for the RDS instance"
  default = "admin"
}

variable "password"{
  description = "The password for the RDS instance" 
  sensitive = true
}

variable "subnet_group_name"{
  description = "The name of the DB subnet group"
  default = "main-db-subnet-group"
}

variable "subnet_ids"{
  description = "The list of subnet IDs for the DB subnet group"
  type = list(string)
}

variable "security_group_ids" {
  description = "The list of security group IDs to associate with the RDS instance"
  type        = list(string)
}

variable "db_instance_name"{
  description = "A name for the RDS instance"
  default = "MyRDSInstance"
}

variable "skip_final_snapshot"{
  description = "Whether to skip creating a final snapshot before deleting the DB instance"
  default = true
}
