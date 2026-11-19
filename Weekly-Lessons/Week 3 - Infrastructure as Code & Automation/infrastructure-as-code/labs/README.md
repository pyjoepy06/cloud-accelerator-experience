# Guided Lab — Static Terraform, Two EC2 Servers

1. Read `terraform/main.tf`: locate one VPC, three subnets, three route tables, and three associations.
2. Read `terraform/servers.tf`: locate the web EC2 in `app_subnet` and MySQL EC2 in `db_subnet`.
3. Explain the two startup scripts and how `templatefile` passes the database IP and generated password.
4. Authenticate to a disposable AWS account and run `aws sts get-caller-identity`.
5. In the `terraform` folder run `terraform init`, `terraform fmt`, `terraform validate`, and `terraform plan`.
6. Run `terraform apply` and approve the plan.
7. Wait for EC2 initialization. Run `terraform output web_url`; visit that URL, `/health`, and `/customers`.
8. In AWS Console, inspect VPC, subnet, route-table, instance, and security-group relationships.
9. Run `terraform destroy` and verify cleanup.

**Instructor note:** The database and application subnets are internet-routed only to allow package installs without NAT costs; do not call them production-private. Do not commit state files or credentials.
