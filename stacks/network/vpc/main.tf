locals {
  dev_config = yamldecode(file("../../../account_configuration/dev/network.yaml"))
}

module "vpc" {
  for_each = toset(local.dev_config["enabled"] ? ["enabled"] : [])

  source = "../../../modules/network/vpc"

  vpc_cidr = local.dev_config.network.vpc_cidr
}
