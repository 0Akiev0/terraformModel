variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = string
}

variable "private_subnet_cidr_az1" {
  description = "The CIDR block for the private subnet in AZ 1"
  type        = string
}

variable "private_subnet_cidr_az2" {
  description = "The CIDR block for the private subnet in AZ 2"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "public_subnet_name" {
  description = "The name of the public subnet"
  type        = string
}

variable "private_subnet_name_az1" {
  description = "The name of the private subnet in AZ 1"
  type        = string
}

variable "private_subnet_name_az2" {
  description = "The name of the private subnet in AZ 2"
  type        = string
}

variable "internet_gateway_name" {
  description = "The name of the internet gateway"
  type        = string
}

variable "route_table_name" {
  description = "The name of the public route table"
  type        = string
}

variable "availability_zone_1" {
  description = "The first availability zone"
  type        = string
}

variable "availability_zone_2" {
  description = "The second availability zone"
  type        = string
}

variable "availability_zone_public" {
  description = "The availability zone for the public subnet"
  type        = string
}
