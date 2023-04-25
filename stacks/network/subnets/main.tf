locals {
  dev_config = yamldecode(file("../../../account_configuration/dev/network.yaml"))
}

data "aws_vpc" "vpc_data" {
  filter {
    name   = "tag:Name"
    values = ["main_VPC"]
  }
}

module "private_subnets" {

  source = "../../../modules/network/subnets/private"

  vpc_id = data.aws_vpc.vpc_data.id
  cidrs  = local.dev_config.network["private_subnet_cidrs"]
}

module "public_subnets" {

  source = "../../../modules/network/subnets/public"

  vpc_id = data.aws_vpc.vpc_data.id
  cidrs  = local.dev_config.network["public_subnet_cidrs"]
}