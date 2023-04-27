# ${path_relative_to_include()}: returns the relative path between the current terragrunt.hcl and other terragrunt.hcl files in child directories
# in simply words: 
#include {
# path = find_in_parent_folders()
# } 
# in childs configuration takes the settings from above directories - like this one here. Then path_relative_to_include is the path between this child and root module
# this is the way to create unique key for each module

# ${get_aws_account_id()}: which returns the AWS account id associated with the current set of credentials, so it will help providing better naming convention based on the AWS account.

locals {
    env_name = yamldecode(file("account_configuration/dev/general.yaml"))["environment"]
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "terraform-state-${local.env_name}-${get_aws_account_id()}"

    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "my-lock-table"
  }
}   
