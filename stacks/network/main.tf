locals {
  dev_config     = yamldecode(file("../../account_configuration/dev/network.yaml"))
  general_config = yamldecode(file("../../account_configuration/dev/general.yaml"))
}

module "vpc" {
  # for_each = toset(local.dev_config["enabled"] ? ["enabled"] : [])

  source = "../../modules/network/vpc"

  vpc_cidr   = local.dev_config.network.vpc_cidr
  tag_suffix = local.general_config.tag_suffix
}

module "private_subnets" {

  source = "../../modules/network/subnets/private"

  vpc_id     = module.vpc.vpc_id
  cidrs      = local.dev_config.network["private_subnet_cidrs"]
  tag_suffix = local.general_config.tag_suffix
}

module "public_subnets" {

  source = "../../modules/network/subnets/public"

  vpc_id     = module.vpc.vpc_id
  cidrs      = local.dev_config.network["public_subnet_cidrs"]
  tag_suffix = local.general_config.tag_suffix
}

