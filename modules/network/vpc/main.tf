data "aws_region" "current" {}

resource "aws_vpc" "main_vpc" {

  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name            = "main_VPC"
    Region          = data.aws_region.current.name
    Region_Endpoint = data.aws_region.current.endpoint
  }

}
