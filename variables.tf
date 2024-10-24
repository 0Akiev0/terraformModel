variable "instance_type"{
  default = "t2.micro"
  description = "type of instance to use for the EC2 servers"
}

variable "region" {
  default = "us-east-2"
  description = "AWS region"
}

variable "key_name" {
  default = "my-ec2-key"
  description = "Name of the SSH key pair"
}

variable "availability_zone"{
  default = "us-east-2a"
  description = "AWS availability zone"
}

variable "db_password" {
  description = "Password for the RDS database"
  type = string 
  sensitive = true 
}
