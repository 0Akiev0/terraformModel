output "vpc_id" {
  value = aws_vpc.this.id
  description = "The ID of the VPC"
}

output "public_subnet_id" {
  value = aws_subnet.public.id
  description = "The ID of the public subnet"
}

output "private_subnet_az1_id" {
  value = aws_subnet.private_az1.id
  description = "The ID of the private subnet in AZ 1"
}

output "private_subnet_az2_id" {
  value = aws_subnet.private_az2.id
  description = "The ID of the private subnet in AZ 2"
}
