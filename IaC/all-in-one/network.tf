################################
##Create private network space##
################################

# Create VPC
resource "aws_vpc" "main" {
  cidr_block = "10.10.0.0/16"

  # Enabling automatic hostname assigning
  enable_dns_hostnames = true

  tags = {
    Name = "EPAM Final Project VPC"
  }
}



# Create Subnet for our instances
resource "aws_subnet" "main" {

  depends_on = [aws_vpc.main]

  vpc_id = aws_vpc.main.id

  cidr_block = "10.10.10.0/24"

  # Enabling automatic public IP assignment on instance launch!
  map_public_ip_on_launch = true

  tags = {
    Name = "EPAM Final Project Subnet"
  }
}

# Create Internet gateway
resource "aws_internet_gateway" "main" {

  depends_on = [
    aws_vpc.main,
    aws_subnet.main
  ]

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "EPAM Final Project Internet Gateway"
  }
}

# Create Route Table for access from Internet
resource "aws_route_table" "main" {

  depends_on = [
    aws_vpc.main,
    aws_internet_gateway.main
  ]

  vpc_id = aws_vpc.main.id

  # to enable connection from outside
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "EPAM Final Project RT"
  }
}

# Assign RT to our Subnet
resource "aws_route_table_association" "main" {
  depends_on = [
    aws_vpc.main,
    aws_subnet.main,
    aws_route_table.main
  ]

  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}

