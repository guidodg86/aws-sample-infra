# aws-sample-infra

Creates mock infrastructure in aws and document networks in netbox

### Subnets in AWS
| Site | Subnet | Role | Description
| --- | --- | --- | --- |
| aws | 10.0.1.0/24 | PRINTER_NETGROUP | Subnet for printer server|
| aws | 10.0.2.0/24 | CCTV_NETGROUP | Subnet for cctv server|
| aws | 10.0.3.0/24 | SRV_NETGROUP | Subnet for some server|
| aws | 10.0.4.0/24 | DATABASE_NETGROUP | Subnet for database |
| aws | 10.0.6.0/24 | KUBERNETES_NETGROUP | Subnet for some kubernetes pods |

Each subnet has one EC2 ubuntu instance

### Subnets outside AWS
Outside AWS we will create two branch sites `bue1` and `ltv2`. The following subnets will be created:

| Site | Subnet | Role | Description
| --- | --- | --- | --- |
| bue1 | 10.1.10.0/24 | HR_NETGROUP | Subnet for hr users|
| bue1 | 10.1.11.0/24 | DEV_NETGROUP | Subnet for developer users|
| bue1 | 10.1.12.0/24 | SRE_NETGROUP | Subnet for sre users|
| bue1 | 10.1.13.0/24 | SEC_NETGROUP | Subnet for security users|
| ltv2 | 10.2.10.0/24 | HR_NETGROUP | Subnet for hr users|
| ltv2 | 10.2.11.0/24 | DEV_NETGROUP | Subnet for developer users|
| ltv2 | 10.2.12.0/24 | SRE_NETGROUP | Subnet for sre users|
| ltv2 | 10.2.13.0/24 | SEC_NETGROUP | Subnet for security users|

### Access matrix
Security groups :male_detective: will be created also to provide the following access matrix, controlling traffic that ingress to different ec2 instances only. Egress traffic will be always allowed towards any cidr in any port. Rules are described the following way `rule_name -> source_role -> destination_role -> destination_port`. All source ports are allowed

Inbound
    HR__PRINTER     -> HR_NETGROUP      -> PRINTER_NETGROUP  -> tcp=9000
    DEV__DATABASE   -> DEV_NETGROUP     -> DATABASE_NETGROUP -> tcp=9010,990;udp=3000-3200
    SRE__SRV        -> SRE_NETGROUP     -> SRV_NETGROUP      -> tcp=9900,2000-3000;udp=53
    SRE__KUBERNETES -> SRE_NETGROUP     -> SRV_KUBERNETES    -> tcp=9900
    SEC__CCTV       -> SEC_NETGROUP     -> CCTV_NETGROUP     -> tcp=443
    any__PRINTER    -> any              -> PRINTER_NETGROUP  -> tcp=443,udp=1000-1200
    ec2__ec2        -> any Ec2 instance -> any Ec2 instance  -> tcp=80

Outbound
    SEC__CCTV       -> CCTV_NETGROUP    -> SEC_NETGROUP      -> tcp=443
    ec2__ec2        -> any Ec2 instance -> any Ec2 instance  -> tcp=8000-9000

> [!IMPORTANT]
> Last rule will be created referring to security group
