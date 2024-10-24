variable "name" {
  description = "The name of the security group"
}

variable "description" {
  description = "Description of the security group"
  default     = "Security group created by Terraform"
}

variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
}

variable "from_port" {
  description = "The starting port for the ingress rule"
  type        = number
}

variable "to_port" {
  description = "The ending port for the ingress rule"
  type        = number
}

variable "allowed_cidr_block" {
  description = "The CIDR block allowed to access the resource"
  type        = string
  default     = "0.0.0.0/0"
}
