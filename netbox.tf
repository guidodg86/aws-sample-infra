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
  site_id     = netbox_site.aws.id
  role_id     = netbox_ipam_role.printer.id
  description = "R-PRINTER_NETGROUP-aws"
}

resource "netbox_prefix" "cctv" {
  prefix      = "10.0.2.0/24"
  status      = "active"
  site_id     = netbox_site.aws.id
  role_id     = netbox_ipam_role.cctv.id
  description = "R-CCTV_NETGROUP-aws"
}

resource "netbox_prefix" "srv" {
  prefix      = "10.0.3.0/24"
  status      = "active"
  site_id     = netbox_site.aws.id
  role_id     = netbox_ipam_role.srv.id
  description = "R-SRV_NETGROUP-aws"
}

resource "netbox_prefix" "database" {
  prefix      = "10.0.4.0/24"
  status      = "active"
  site_id     = netbox_site.aws.id
  role_id     = netbox_ipam_role.database.id
  description = "R-DATABASE_NETGROUP-aws"
}

resource "netbox_prefix" "kubernetes" {
  prefix      = "10.0.5.0/24"
  status      = "active"
  site_id     = netbox_site.aws.id
  role_id     = netbox_ipam_role.kubernetes.id
  description = "R-KUBERNETES_NETGROUP-aws"
}

resource "netbox_prefix" "hr-bue1" {
  prefix      = "10.1.10.0/24"
  status      = "active"
  site_id     = netbox_site.bue1.id
  role_id     = netbox_ipam_role.hr.id
  description = "R-HR_NETGROUP-bue1"
}

resource "netbox_prefix" "hr-ltv2" {
  prefix      = "10.2.10.0/24"
  status      = "active"
  site_id     = netbox_site.ltv2.id
  role_id     = netbox_ipam_role.hr.id
  description = "R-HR_NETGROUP-ltv2"
}

resource "netbox_prefix" "dev-bue1" {
  prefix      = "10.1.11.0/24"
  status      = "active"
  site_id     = netbox_site.bue1.id
  role_id     = netbox_ipam_role.dev.id
  description = "R-DEV_NETGROUP-bue1"
}

resource "netbox_prefix" "dev-ltv2" {
  prefix      = "10.2.11.0/24"
  status      = "active"
  site_id     = netbox_site.ltv2.id
  role_id     = netbox_ipam_role.dev.id
  description = "R-DEV_NETGROUP-ltv2"
}

resource "netbox_prefix" "sre-bue1" {
  prefix      = "10.1.12.0/24"
  status      = "active"
  site_id     = netbox_site.bue1.id
  role_id     = netbox_ipam_role.sre.id
  description = "R-SRE_NETGROUP-bue1"
}

resource "netbox_prefix" "sre-ltv2" {
  prefix      = "10.2.12.0/24"
  status      = "active"
  site_id     = netbox_site.ltv2.id
  role_id     = netbox_ipam_role.sre.id
  description = "R-SRE_NETGROUP-ltv2"
}

resource "netbox_prefix" "sec-bue1" {
  prefix      = "10.1.13.0/24"
  status      = "active"
  site_id     = netbox_site.bue1.id
  role_id     = netbox_ipam_role.sec.id
  description = "R-SEC_NETGROUP-bue1"
}

resource "netbox_prefix" "sec-ltv2" {
  prefix      = "10.2.13.0/24"
  status      = "active"
  site_id     = netbox_site.ltv2.id
  role_id     = netbox_ipam_role.sec.id
  description = "R-SEC_NETGROUP-ltv2"
}