# Week 3: Static Terraform web application lab

Read `main.tf` first: **one VPC, five explicitly declared subnets, three route tables, and five explicit associations**. Then read `servers.tf`: two security groups and two EC2 instances. The supplied `.tftpl` files install Flask and MySQL.

## Subnets and Availability Zones

| Tier | AZ | Subnet | CIDR | EC2 |
|---|---|---|---|---|
| Web | us-east-1a | web_subnet | 10.30.1.0/24 | None yet |
| Web | us-east-1b | web_subnet_b | 10.30.4.0/24 | None yet |
| Application | us-east-1a | app_subnet | 10.30.2.0/24 | Flask web app |
| Database | us-east-1a | db_subnet | 10.30.3.0/24 | MySQL |
| Database | us-east-1b | db_subnet_b | 10.30.5.0/24 | None yet |

The two web subnets share the existing web route table. The two database subnets share the existing database route table. **No new route tables, NAT Gateways, or EC2 instances** were added in this extension.

This is a **multi-AZ subnet foundation**, not a highly available application. There is still only one Flask EC2 and one MySQL EC2, both in AZ A. Actual application availability would require redundant compute and traffic distribution; database availability requires replication and failover.

## Beginner Terraform rules

No modules, input variables, `locals`, `count`, `for_each`, or loops. CIDRs, regions, AZs, instance types, and ports are written directly in the resource blocks. Resource references like `aws_vpc.class_vpc.id` are how Terraform connects resources; they are not input variables.

The AMI is selected by a `data "aws_ami"` lookup. A `random_password` resource creates the MySQL password rather than hardcoding it. The password is still present in Terraform state and EC2 user data; use a disposable lab account only.

## Classroom-only networking compromise

To allow `apt` installation without a NAT Gateway, the app and both database subnets have Internet Gateway routes and automatic public IPv4 assignment. The database security group permits MySQL only from the application security group. **These are not production-private database subnets.** EC2 and public IPv4 addresses may incur charges.

## Commands

```bash
aws sts get-caller-identity
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
terraform output web_url
terraform destroy
```

Wait several minutes for startup scripts. Visit the web URL, `/health`, and `/customers`. Confirm all five subnets and five route-table associations in the AWS Console.

Never commit credentials, state files, or private keys. Always destroy the lab when finished.
