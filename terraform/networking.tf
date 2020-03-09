resource "aws_db_subnet_group" "private" {
  name = "microservices-db-subnet-group-private"
  subnet_ids = [
    aws_subnet.microservice-subnet-private-1.id,
    aws_subnet.microservice-subnet-private-2.id
  ]

  tags = {
    Name = "Private DB Subnet Group"
  }
}

resource "aws_internet_gateway" "microservice-gateway" {
  vpc_id = aws_vpc.microservice.id
}

resource "aws_route_table" "allow-outgoing-access" {
  vpc_id = aws_vpc.microservice.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.microservice-gateway.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "microservice-subnet-public" {
  subnet_id = aws_subnet.microservice-subnet-public.id
  route_table_id = aws_route_table.allow-outgoing-access.id
}

resource "aws_route_table_association" "microservice-subnet-private-1" {
  subnet_id = aws_subnet.microservice-subnet-private-1.id
  route_table_id = aws_route_table.allow-outgoing-access.id
}

resource "aws_security_group" "allow-internal-http" {
  name = "allow-internal-http"
  description = "Allow internal http requests"
  vpc_id = aws_vpc.microservice.id
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = [
      aws_vpc.microservice.cidr_block]
  }
}

resource "aws_security_group" "allow-internal-mysql" {
  name = "allow-internal-mysql"
  description = "Allow internal mysql requests"
  vpc_id = aws_vpc.microservice.id

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = [
      aws_vpc.microservice.cidr_block]
  }
}

resource "aws_security_group" "allow-http" {
  name = "allow-http"
  description = "Allow http inbound requests"
  vpc_id = aws_vpc.microservice.id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow-ssh" {
  name = "allow-ssh"
  description = "Allow ssh inbound requests"
  vpc_id = aws_vpc.microservice.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow-all-outbound" {
  name = "allow-all-outbound"
  description = "Allow all outbound requests"
  vpc_id = aws_vpc.microservice.id

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "microservice-subnet-public" {
  availability_zone_id = "usw1-az1"
  cidr_block = "10.0.0.0/24"
  vpc_id = aws_vpc.microservice.id

  tags = {
    Name = "Microservice subnet (Public)"
  }
}
resource "aws_subnet" "microservice-subnet-private-1" {
  availability_zone_id = "usw1-az1"
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.microservice.id

  tags = {
    Name = "Microservice subnet (Private 1)"
  }
}
resource "aws_subnet" "microservice-subnet-private-2" {
  availability_zone_id = "usw1-az3"
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.microservice.id

  tags = {
    Name = "Microservice subnet (Private 2)"
  }
}

resource "aws_vpc" "microservice" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "Microservice VPC"
  }
}