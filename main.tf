# Deploy testing vpc
resource "aws_vpc" "testing_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

# Deploy the private subnets
resource "aws_subnet" "private_subnets" {
  for_each          = var.subnets
  vpc_id            = aws_vpc.testing_vpc.id
  cidr_block        = each.value["cidr"]
  availability_zone = each.value["az"]

  tags = {
    Name = each.value["name"]
  }
}

resource "aws_instance" "ubuntu_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnets["server"].id
  security_groups             = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true

  tags = {
    Name = "printer-server"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.testing_vpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_subnet.private_subnets["server"].cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic inside sg"
  vpc_id      = aws_vpc.testing_vpc.id

  ingress {
    description      = "HTTP from sg"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    self = true
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http"
  }
}