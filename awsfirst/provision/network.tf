data "aws_vpc" "default-vpc" {
  default = true
}

data "aws_internet_gateway" "default-internet-gateway" {
  internet_gateway_id = "igw-0b5243be557cc129b"
}

resource "aws_subnet" "awsfirst-subnet-public-a" {
  vpc_id     = data.aws_vpc.default-vpc.id
  cidr_block = "172.31.48.0/26"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "awsfirst-public-a"
  }
}

resource "aws_subnet" "awsfirst-subnet-private" {
  vpc_id     = data.aws_vpc.default-vpc.id
  cidr_block = "172.31.49.0/26"

  tags = {
    Name = "awsfirst-private"
  }
}

resource "aws_subnet" "awsfirst-subnet-public-b" {
  vpc_id     = data.aws_vpc.default-vpc.id
  cidr_block = "172.31.50.0/26"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "awsfirst-public-b"
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

resource "aws_route_table" "awsfirst-route-private" {
  vpc_id = data.aws_vpc.default-vpc.id

  tags = {
    Name = "awsfirst-private"
  }
}


resource "aws_route_table_association" "awsfirst-public-a-subnet-igw" {
  subnet_id      = aws_subnet.awsfirst-subnet-public-a.id
  route_table_id = aws_route_table.awsfirst-route-public.id
}

resource "aws_route_table_association" "awsfirst-public-b-subnet-igw" {
  subnet_id      = aws_subnet.awsfirst-subnet-public-b.id
  route_table_id = aws_route_table.awsfirst-route-public.id
}

resource "aws_route_table_association" "awsfirst-private-subnet-rtb" {
  subnet_id      = aws_subnet.awsfirst-subnet-private.id
  route_table_id = aws_route_table.awsfirst-route-private.id
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

resource "aws_security_group_rule" "awsfirst-public-egress-http" {
  type              = "egress"
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

resource "aws_vpc_endpoint" "awsfirst-ecr-endpoint" {
  vpc_id       = data.aws_vpc.default-vpc.id
  service_name = "com.amazonaws.eu-west-2.ecr.api"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  security_group_ids = [
    aws_security_group.awsfirst-private-subnet-sg.id
  ]
  subnet_ids = [aws_subnet.awsfirst-subnet-private.id]
}

resource "aws_vpc_endpoint" "awsfirst-dkr-endpoint" {
  vpc_id       = data.aws_vpc.default-vpc.id
  service_name = "com.amazonaws.eu-west-2.ecr.dkr"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  security_group_ids = [
    aws_security_group.awsfirst-private-subnet-sg.id
  ]
  subnet_ids = [aws_subnet.awsfirst-subnet-private.id]
}

resource "aws_vpc_endpoint" "awsfirst-s3-endpoint" {
  vpc_id       = data.aws_vpc.default-vpc.id
  service_name = "com.amazonaws.eu-west-2.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids = [aws_route_table.awsfirst-route-private.id]
}

resource "aws_vpc_endpoint" "awsfirst-secrets-endpoint" {
  vpc_id       = data.aws_vpc.default-vpc.id
  service_name = "com.amazonaws.eu-west-2.secretsmanager"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  security_group_ids = [
    aws_security_group.awsfirst-private-subnet-sg.id
  ]
  subnet_ids = [aws_subnet.awsfirst-subnet-private.id]
}

resource "aws_vpc_endpoint" "awsfirst-logs-endpoint" {
  vpc_id       = data.aws_vpc.default-vpc.id
  service_name = "com.amazonaws.eu-west-2.logs"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  security_group_ids = [
    aws_security_group.awsfirst-private-subnet-sg.id
  ]
  subnet_ids = [aws_subnet.awsfirst-subnet-private.id]
}

resource "aws_security_group" "awsfirst-private-subnet-sg" {
  name        = "awsfirst-private"
  description = "VPC Endpoint"
  vpc_id      = data.aws_vpc.default-vpc.id

  tags = {
    Name = "awsfirst-private"
  }
}

resource "aws_security_group_rule" "awsfirst-private-https-ingress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.awsfirst-private-subnet-sg.id
  
}

resource "aws_security_group_rule" "awsfirst-private-https-egress" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.awsfirst-private-subnet-sg.id
}

resource "aws_security_group_rule" "awsfirst-private-http-ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.awsfirst-private-subnet-sg.id
}