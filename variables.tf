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
    printer = {
      "cidr" = "10.0.1.0/24",
      "name" = "PRINTER_NETGROUP",
      "az"   = "us-east-1a"
    }
    cctv = {
      "cidr" = "10.0.2.0/24",
      "name" = "CCTV_NETGROUP",
      "az"   = "us-east-1b"
    }
    server = {
      "cidr" = "10.0.3.0/24",
      "name" = "SRV_NETGROUP",
      "az"   = "us-east-1c"
    }
    database = {
      "cidr" = "10.0.4.0/24",
      "name" = "DATABASE_NETGROUP",
      "az"   = "us-east-1d"
    }
    kubernetes = {
      "cidr" = "10.0.6.0/24",
      "name" = "KUBERNETES_NETGROUP",
      "az"   = "us-east-1e"
    }
  }

}


