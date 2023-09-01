resource "netbox_rir" "test" {
  name = "RFC 1918"
}

resource "netbox_aggregate" "aws_agg" {
  prefix      = "10.0.0.0/16"
  description = format("aws - account=%s - region=%s - vpc_id=%s", data.aws_caller_identity.current.account_id, var.aws_region, aws_vpc.testing_vpc.id)
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
  description = aws_subnet.private_subnets["PRINTER_NETGROUP-aws-1"].id
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

resource "netbox_device_role" "ec2-role" {
  name      = "ec2 instance"
  color_hex = "5832a8"
}

resource "netbox_manufacturer" "aws-manufacturer" {
  name = "aws"
}

resource "netbox_device_type" "ubuntu-instance" {
  model           = "ubuntu"
  manufacturer_id = netbox_manufacturer.aws-manufacturer.id
}

resource "netbox_device" "printer-server" {
  name           = aws_instance.printer-server.tags.Name
  device_type_id = netbox_device_type.ubuntu-instance.id
  role_id        = netbox_device_role.ec2-role.id
  site_id        = netbox_site.aws.id
  serial         = aws_instance.printer-server.id
}

resource "netbox_device_interface" "printer-server-int" {
  name      = "eth0"
  device_id = netbox_device.printer-server.id
  type      = "1000base-t"
}

resource "netbox_ip_address" "printer-server-ip" {
  ip_address   = format("%s/%s", aws_instance.printer-server.private_ip, split("/", aws_subnet.private_subnets["PRINTER_NETGROUP-aws-1"].cidr_block)[1])
  status       = "active"
  interface_id = netbox_device_interface.printer-server-int.id
  object_type  = "dcim.interface"
}

resource "netbox_device" "cctv-server" {
  name           = aws_instance.cctv-server.tags.Name
  device_type_id = netbox_device_type.ubuntu-instance.id
  role_id        = netbox_device_role.ec2-role.id
  site_id        = netbox_site.aws.id
  serial         = aws_instance.cctv-server.id
}

resource "netbox_device_interface" "cctv-server-int" {
  name      = "eth0"
  device_id = netbox_device.cctv-server.id
  type      = "1000base-t"
}

resource "netbox_ip_address" "cctv-server-ip" {
  ip_address   = format("%s/%s", aws_instance.cctv-server.private_ip, split("/", aws_subnet.private_subnets["CCTV_NETGROUP-aws-1"].cidr_block)[1])
  status       = "active"
  interface_id = netbox_device_interface.cctv-server-int.id
  object_type  = "dcim.interface"
}

resource "netbox_device" "srv-server" {
  name           = aws_instance.srv-server.tags.Name
  device_type_id = netbox_device_type.ubuntu-instance.id
  role_id        = netbox_device_role.ec2-role.id
  site_id        = netbox_site.aws.id
  serial         = aws_instance.srv-server.id
}

resource "netbox_device_interface" "srv-server-int" {
  name      = "eth0"
  device_id = netbox_device.srv-server.id
  type      = "1000base-t"
}

resource "netbox_ip_address" "srv-server-ip" {
  ip_address   = format("%s/%s", aws_instance.srv-server.private_ip, split("/", aws_subnet.private_subnets["SRV_NETGROUP-aws-1"].cidr_block)[1])
  status       = "active"
  interface_id = netbox_device_interface.srv-server-int.id
  object_type  = "dcim.interface"
}

resource "netbox_device" "database-server" {
  name           = aws_instance.database-server.tags.Name
  device_type_id = netbox_device_type.ubuntu-instance.id
  role_id        = netbox_device_role.ec2-role.id
  site_id        = netbox_site.aws.id
  serial         = aws_instance.database-server.id
}

resource "netbox_device_interface" "database-server-int" {
  name      = "eth0"
  device_id = netbox_device.database-server.id
  type      = "1000base-t"
}

resource "netbox_ip_address" "database-server-ip" {
  ip_address   = format("%s/%s", aws_instance.database-server.private_ip, split("/", aws_subnet.private_subnets["DATABASE_NETGROUP-aws-1"].cidr_block)[1])
  status       = "active"
  interface_id = netbox_device_interface.database-server-int.id
  object_type  = "dcim.interface"
}

resource "netbox_device" "kubernetes-cluster" {
  name           = aws_instance.kubernetes-cluster.tags.Name
  device_type_id = netbox_device_type.ubuntu-instance.id
  role_id        = netbox_device_role.ec2-role.id
  site_id        = netbox_site.aws.id
  serial         = aws_instance.kubernetes-cluster.id
}

resource "netbox_device_interface" "kubernetes-cluster-int" {
  name      = "eth0"
  device_id = netbox_device.kubernetes-cluster.id
  type      = "1000base-t"
}

resource "netbox_ip_address" "kubernetes-cluster-ip" {
  ip_address   = format("%s/%s", aws_instance.kubernetes-cluster.private_ip, split("/", aws_subnet.private_subnets["KUBERNETES_NETGROUP-aws-1"].cidr_block)[1])
  status       = "active"
  interface_id = netbox_device_interface.kubernetes-cluster-int.id
  object_type  = "dcim.interface"
}