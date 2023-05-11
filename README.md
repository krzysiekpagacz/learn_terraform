# learn_terraform
AWS credentials are set via `aws configure`

To run this code:
1. from root directory execute `terragrunt init`. It will create S3 bucket for storing remote state. Confirm this
2. execute `terragrunt run-all apply`. All resources will be created.

To do:
* add option to choose stage to be provisioned. For now only dev will be provisione and this needs to be changed so that tf will be executed based on the account given
* follow guide to set up k8s cluster: https://medium.com/devops-mojo/terraform-provision-amazon-eks-cluster-using-terraform-deploy-create-aws-eks-kubernetes-cluster-tf-4134ab22c594