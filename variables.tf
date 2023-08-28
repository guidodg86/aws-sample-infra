variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_name" {
  type    = string
  default = "testing_vpc"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnets" {
  type = map(any)
  default = {
    PRINTER_NETGROUP-aws-1 = {
      "cidr"     = "10.0.1.0/24",
      "netgroup" = "PRINTER_NETGROUP",
      "az"       = "us-east-1a"
    }
    CCTV_NETGROUP-aws-1 = {
      "cidr"     = "10.0.2.0/24",
      "netgroup" = "CCTV_NETGROUP",
      "az"       = "us-east-1b"
    }
    SRV_NETGROUP-aws-1 = {
      "cidr"     = "10.0.3.0/24",
      "netgroup" = "SRV_NETGROUP",
      "az"       = "us-east-1c"
    }
    DATABASE_NETGROUP-aws-1 = {
      "cidr"     = "10.0.4.0/24",
      "netgroup" = "DATABASE_NETGROUP",
      "az"       = "us-east-1d"
    }
    KUBERNETES_NETGROUP-aws-1 = {
      "cidr"     = "10.0.6.0/24",
      "netgroup" = "KUBERNETES_NETGROUP",
      "az"       = "us-east-1e"
    }
  }

}


