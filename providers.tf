# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}
provider "netbox" {
  server_url = "http://127.0.0.1:8000"
  api_token  = var.netbox_token
}