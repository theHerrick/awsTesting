data "aws_vpc" "default-vpc" {
  default = true
}

data "aws_internet_gateway" "default-internet-gateway" {
  internet_gateway_id = "igw-0b5243be557cc129b"
}

resource "aws_subnet" "awsfirst-subnet-public" {
  vpc_id     = data.aws_vpc.default-vpc.id
  cidr_block = "172.31.48.0/26"

  tags = {
    Name = "awsfirst-public"
  }
}

resource "aws_subnet" "awsfirst-subnet-private" {
  vpc_id     = data.aws_vpc.default-vpc.id
  cidr_block = "172.31.49.0/26"

  tags = {
    Name = "awsfirst-private"
  }
}

resource "aws_route_table" "awsfirst-route-public" {
  vpc_id = data.aws_vpc.default-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.default-internet-gateway.id
  }

  tags = {
    Name = "awsfirst-public"
  }
}

resource "aws_route_table_association" "awsfirst-public-subnet-igw" {
  subnet_id      = aws_subnet.awsfirst-subnet-public.id
  route_table_id = aws_route_table.awsfirst-route-public.id
}

resource "aws_security_group" "awsfirst-public-subnet-sg" {
  name        = "awsfirst-public"
  description = "Allow http/https"
  vpc_id      = data.aws_vpc.default-vpc.id

  tags = {
    Name = "awsfirst-public"
  }
}

resource "aws_security_group_rule" "awsfirst-public-http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.awsfirst-public-subnet-sg.id
}

resource "aws_security_group_rule" "awsfirst-public-https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.awsfirst-public-subnet-sg.id
}