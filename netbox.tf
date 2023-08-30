resource "netbox_rir" "test" {
  name = "RFC 1918"
}

resource "netbox_aggregate" "aws_agg" {
  prefix      = "10.0.0.0/16"
  description = "aws"
  rir_id      = netbox_rir.test.id
}

resource "netbox_aggregate" "bue1_agg" {
  prefix      = "10.1.0.0/16"
  description = "bue1"
  rir_id      = netbox_rir.test.id
}

resource "netbox_aggregate" "ltv2_agg" {
  prefix      = "10.2.0.0/16"
  description = "ltv2"
  rir_id      = netbox_rir.test.id
}

resource "netbox_site" "aws" {
  name   = "aws"
  status = "active"
}

resource "netbox_site" "bue1" {
  name   = "bue1"
  status = "active"
}

resource "netbox_site" "ltv2" {
  name   = "ltv2"
  status = "active"
}

resource "netbox_ipam_role" "printer" {
  name = "PRINTER_NETGROUP"
}

resource "netbox_ipam_role" "cctv" {
  name = "CCTV_NETGROUP"
}

resource "netbox_ipam_role" "srv" {
  name = "SRV_NETGROUP"
}

resource "netbox_ipam_role" "database" {
  name = "DATABASE_NETGROUP"
}

resource "netbox_ipam_role" "kubernetes" {
  name = "KUBERNETES_NETGROUP"
}

resource "netbox_ipam_role" "hr" {
  name = "HR_NETGROUP"
}

resource "netbox_ipam_role" "dev" {
  name = "DEV_NETGROUP"
}

resource "netbox_ipam_role" "sre" {
  name = "SRE_NETGROUP"
}

resource "netbox_ipam_role" "sec" {
  name = "SEC_NETGROUP"
}

resource "netbox_prefix" "printer" {
  prefix      = "10.0.1.0/24"
  status      = "active"
  site_id = netbox_site.aws.id
  role_id = netbox_ipam_role.printer.id
  description = "R-PRINTER_NETGROUP-aws"
}