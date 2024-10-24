resource "aws_instance" "this"{
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids      = var.security_group_ids
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true  # Ensure public IP association
  tags = {
    Name = var.instance_name
  }
}
