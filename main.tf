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
    Name     = each.key
    Netgroup = each.value["netgroup"]
  }
}

# resource "aws_instance" "ubuntu_server" {
#   ami                         = data.aws_ami.ubuntu.id
#   instance_type               = "t2.micro"
#   subnet_id                   = aws_subnet.private_subnets["PRINTER_NETGROUP-aws-1"].id
#   security_groups             = [aws_security_group.allow_printer.id, aws_security_group.allow_http.id]
#   associate_public_ip_address = true

#   tags = {
#     Name = "printer-server"
#   }
# }




resource "aws_security_group" "hr__printer" {
  name        = "hr__printer"
  description = "hr__printer"
  vpc_id      = aws_vpc.testing_vpc.id

  ingress {
    description = "tcp=9000"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["10.1.10.0/24", "10.2.10.0/24"]
  }

  ingress {
    description = "tcp=443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "udp=1000-1200"
    from_port   = 1000
    to_port     = 1200
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "hr__printer"
  }
}

resource "aws_security_group" "dev__database" {
  name        = "dev__database"
  description = "dev__database"
  vpc_id      = aws_vpc.testing_vpc.id

  ingress {
    description = "tcp=9010"
    from_port   = 9010
    to_port     = 9010
    protocol    = "tcp"
    cidr_blocks = ["10.1.11.0/24", "10.2.11.0/24"]
  }

  ingress {
    description = "tcp=990"
    from_port   = 990
    to_port     = 990
    protocol    = "tcp"
    cidr_blocks = ["10.1.11.0/24", "10.2.11.0/24"]
  }

  ingress {
    description = "udp=3000-3200"
    from_port   = 3000
    to_port     = 3200
    protocol    = "udp"
    cidr_blocks = ["10.1.11.0/24", "10.2.11.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dev__database"
  }
}

resource "aws_security_group" "sre__srv" {
  name        = "sre__srv"
  description = "sre__srv"
  vpc_id      = aws_vpc.testing_vpc.id

  ingress {
    description = "tcp=9900"
    from_port   = 9900
    to_port     = 9900
    protocol    = "tcp"
    cidr_blocks = ["10.1.12.0/24", "10.2.12.0/24"]
  }

  ingress {
    description = "tcp=2000-3000"
    from_port   = 2000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["10.1.12.0/24", "10.2.12.0/24"]
  }

  ingress {
    description = "udp=53"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["10.1.12.0/24", "10.2.12.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sre__srv"
  }
}

resource "aws_security_group" "sre__kubernetes" {
  name        = "sre__kubernetes"
  description = "sre__kubernetes"
  vpc_id      = aws_vpc.testing_vpc.id

  ingress {
    description = "tcp=9900"
    from_port   = 9900
    to_port     = 9900
    protocol    = "tcp"
    cidr_blocks = ["10.1.12.0/24", "10.2.12.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sre__kubernetes"
  }
}

resource "aws_security_group" "sec__cctv" {
  name        = "sec__cctv"
  description = "sec__cctv"
  vpc_id      = aws_vpc.testing_vpc.id

  ingress {
    description = "tcp=443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.1.13.0/24", "10.2.13.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sec__cctv"
  }
}

resource "aws_security_group" "ec2__ec2" {
  name        = "ec2__ec2"
  description = "ec2__ec2"
  vpc_id      = aws_vpc.testing_vpc.id

  ingress {
    description = "tcp=80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2__ec2"
  }
}