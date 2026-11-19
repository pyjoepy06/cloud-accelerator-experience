
# terraform {
#   backend "s3" {
#     bucket       = "cloud-accelerator-tfstate-948806324987"
#     key          = "week3/terraform.tfstate"
#     region       = "us-east-1"
#     encrypt      = true
#     use_lockfile = true
#   }
# }

##Notes about backend.tf resource

# Understand what we're configuring:
# Setting	Purpose
# bucket	S3 bucket containing Terraform state
# key	Path to the state file inside S3
# region	AWS region containing the bucket
# encrypt	Enables encryption of the state object
# use_lockfile	Prevents concurrent Terraform operations from modifying the same state