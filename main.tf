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
  #security_groups             = [aws_security_group.vpc-ping.id, aws_security_group.ingress-ssh.id, aws_security_group.vpc-web.id]
  associate_public_ip_address = true

  tags = {
    Name = "printer-server"
  }
}