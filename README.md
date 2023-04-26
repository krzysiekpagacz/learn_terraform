# learn_terraform
AWS credentials are set via `aws configure`

To run this code:
1. from root directory execute `terragrunt init`. It will create S3 bucket for storing remote state. Confirm this
2. execute `terragrunt run-all apply`. All resources will be created.