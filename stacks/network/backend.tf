# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    bucket         = "terraform-state-dev-859844227048"
    dynamodb_table = "my-lock-table"
    encrypt        = true
    key            = "stacks/network/terraform.tfstate"
    region         = "us-east-1"
  }
}
