resource "aws_vpc" "testing_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

#Deploy the private subnets
resource "aws_subnet" "private_subnets" {
  for_each   = var.subnets
  vpc_id     = aws_vpc.testing_vpc.id
  cidr_block = each.value["cidr"]

  tags = {
    Name = each.value["name"]
  }
}