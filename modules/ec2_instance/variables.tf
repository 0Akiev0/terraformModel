variable "ami" {
  description = "The AMI ID to use for the instance"
}

variable "instance_type"{
  default = "t2.micro"
  description = "Type of instacne to use"
}

variable "key_name"{
  description = "SSH key pair name"
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the instance"
  type        = list(string)
}

variable "subnet_id" {
  description = "The subnet ID to launch the instance in"
}

variable "instance_name"{
  description = "The name to give the instacne"
}
