#Provider Configuration
provider "aws"{
  region = var.region
}

#Data soruce to fetch the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

module "web_security_group" {
  source             = "./modules/security_group"
  name               = "web-security-group"
  description        = "Security group for the web server"
  vpc_id             = module.vpc.vpc_id
  from_port          = 80  # For HTTP access
  to_port            = 80
  allowed_cidr_block = "0.0.0.0/0"  # Allow access from the public internet for HTTP
}

module "ssh_security_group" {
  source             = "./modules/security_group"
  name               = "ssh-security-group"
  description        = "Security group for SSH access"
  vpc_id             = module.vpc.vpc_id
  from_port          = 22  # For SSH access
  to_port            = 22
  allowed_cidr_block = "0.0.0.0/0"  # Allow SSH access from the public internet
}

module "backend_security_group" {
  source             = "./modules/security_group"
  name               = "backend-security-group"
  description        = "Security group for the backend server"
  vpc_id             = module.vpc.vpc_id
  from_port          = 22  # For SSH access
  to_port            = 22
  allowed_cidr_block = "0.0.0.0/0"  # Allow SSH access from anywhere
}

module "rds_security_group" {
  source             = "./modules/security_group"
  name               = "rds-security-group"
  description        = "Security group for RDS instance"
  vpc_id             = module.vpc.vpc_id
  from_port          = 3306  # For MySQL access
  to_port            = 3306
  allowed_cidr_block = "10.0.0.0/16"  # Restrict access to within the VPC
}

#Web Server (EC2 Instance)
module "web_instance" {
  source             = "./modules/ec2_instance"
  ami                = data.aws_ami.amazon_linux.id
  instance_type      = var.instance_type
  key_name           = var.key_name
  instance_name      = "WebServer"
  security_group_ids = [module.web_security_group.security_group_id, module.ssh_security_group.security_group_id]
  subnet_id          = module.vpc.public_subnet_id  # Place the Web Server in the public subnet
}

#Backend Server (EC2 Instance)
module "backend_instance" {
  source             = "./modules/ec2_instance"
  ami                = data.aws_ami.amazon_linux.id
  instance_type      = var.instance_type
  key_name           = var.key_name
  instance_name      = "BackendServer"
  security_group_ids = [module.backend_security_group.security_group_id]  # Use the backend SG
  subnet_id          = module.vpc.public_subnet_id  # Ensure the Backend is in the public subnet
}

module "rds_instance" {
  source              = "./modules/rds_instance"
  allocated_storage   = 20
  engine              = "mysql"
  #engine_version      = "8.0.30"
  instance_class      = "db.t3.micro"
  db_name             = "mydatabase"
  username            = "admin"
  password            = var.db_password
  subnet_group_name   = "main-db-subnet-group"

  # Pass both private subnet IDs
  subnet_ids          = [module.vpc.private_subnet_az1_id, module.vpc.private_subnet_az2_id]

  security_group_ids  = [module.rds_security_group.security_group_id]
  db_instance_name    = "MyRDSInstance"
  skip_final_snapshot = true
}

# S3 Bucket to store applicaiton logs
resource "aws_s3_bucket" "logs"{
  bucket = "application-logs-${random_id.bucket_id.hex}"
  acl = "private"

  tags = {
    Name = "ApplicationLogs"
    Environment = "Dev"
  }
}

module "vpc" {
  source               = "./modules/vpc"

  # VPC Configuration
  cidr_block           = "10.0.0.0/16"
  vpc_name             = "main-vpc"

  # Public Subnet Configuration
  public_subnet_cidr   = "10.0.1.0/24"
  public_subnet_name   = "main-public-subnet"
  availability_zone_public = "us-east-2a"  # Assign the public subnet to an AZ

  # Private Subnet Configuration (for RDS) - Two AZs
  private_subnet_cidr_az1  = "10.0.2.0/24"
  private_subnet_name_az1  = "main-private-subnet-az1"
  
  private_subnet_cidr_az2  = "10.0.3.0/24"
  private_subnet_name_az2  = "main-private-subnet-az2"

  # Internet Gateway and Route Table
  internet_gateway_name = "main-igw"
  route_table_name     = "public-route-table"

  # Availability Zones for Private Subnets
  availability_zone_1    = "us-east-2a"
  availability_zone_2    = "us-east-2b"
}

# Random ID for unique S3 bucket name
resource "random_id" "bucket_id"{
  byte_length = 4
}


# Remote State Backend 

terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket-lab1"
    key = "terraform.tfstate"
    region = "us-east-2"
  }
}

output "web_instance_public_ip" {
  value       = module.web_instance.public_ip
  description = "Public IP address of the Web Server"
}

output "backend_instance_public_ip" {
  value       = module.backend_instance.public_ip
  description = "Public IP address of the Backend Server"
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "rds_endpoint"{
  value = module.rds_instance.rds_endpoint
  description = "The endpoint of the RDS instance"
}
