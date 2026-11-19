# Guided Lab — Five Static Subnets Across Two AZs

1. Read `terraform/main.tf`. Find the VPC, **five** subnet resources, **three** route tables, and **five** associations. Notice that AZ B web and database subnets use the existing route tables.
2. Identify the CIDRs in AZ A (`10.30.1.0/24`, `10.30.2.0/24`, `10.30.3.0/24`) and AZ B (`10.30.4.0/24`, `10.30.5.0/24`).
3. Read `terraform/servers.tf`. Find the Flask EC2 in `app_subnet` and MySQL EC2 in `db_subnet`, both in AZ A.
4. Authenticate to a disposable AWS account and run `aws sts get-caller-identity`.
5. In the `terraform` folder run `terraform init`, `terraform fmt`, `terraform validate`, and `terraform plan`.
6. Run `terraform apply` and approve the plan.
7. Wait for EC2 initialization. Run `terraform output web_url`; visit that URL, `/health`, and `/customers`.
8. In AWS Console, inspect all five subnets and their associations. Compare AZ A and AZ B.
9. Discuss: Why does a second subnet **not** automatically make a single EC2 server or database highly available?
10. Run `terraform destroy` and verify cleanup.

**Instructor note:** This is a multi-AZ networking demonstration, not application/database HA. The database subnets are internet-routed for classroom bootstrap and are not production-private.
