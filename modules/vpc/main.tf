resource "aws_vpc" "this" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.vpc_name
  }
}

# Existing Public Subnet
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone = var.availability_zone_public

  tags = {
    Name = var.public_subnet_name
  }
}

# Add a Private Subnet for RDS
# Private Subnet in AZ 1 (us-east-2a)
resource "aws_subnet" "private_az1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_cidr_az1
  map_public_ip_on_launch = false
  availability_zone = var.availability_zone_1

  tags = {
    Name = var.private_subnet_name_az1
  }
}

# Private Subnet in AZ 2 (us-east-2b)
resource "aws_subnet" "private_az2" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_cidr_az2
  map_public_ip_on_launch = false
  availability_zone = var.availability_zone_2

  tags = {
    Name = var.private_subnet_name_az2
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = var.internet_gateway_name
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = var.route_table_name
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
