terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.13.1"
    }
    netbox = {
      source  = "e-breuninger/netbox"
      version = "~> 3.2.1"
    }
  }
}