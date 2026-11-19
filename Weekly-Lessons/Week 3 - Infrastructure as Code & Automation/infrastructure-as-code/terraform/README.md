# Terraform — Start Here

This is the **first** Week 3 lesson. [Open the static example](main.tf).

## What to notice
- `resource "aws_vpc" "class_vpc"` creates one VPC.
- `aws_vpc.class_vpc.id` is a **reference** to that resource, not a variable you have to supply.
- There are three separate subnet blocks, three route-table blocks, three associations, three security groups, and three EC2 blocks.
- All subnet CIDRs, names, ports, instance types, and region are written directly in `main.tf`.
- The **only** `data` block looks up the current Amazon Linux AMI through AWS Systems Manager. This avoids hardcoding an AMI ID that may become obsolete.
- No `variables.tf`, `terraform.tfvars`, `locals`, `count`, `for_each`, or modules.

## Before starting
Install Terraform and AWS CLI (see the repository's `How-To` directory). Configure AWS credentials using an AWS profile or IAM Identity Center. Use a dedicated lab account and the `us-east-1` region. You need permissions to create VPC networking, security groups, and EC2 instances and to read the public SSM AMI parameter.

## Run
From this folder:

```bash
aws sts get-caller-identity
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

Type `yes` only after reviewing the plan. In AWS Console, locate resources with the `week3-` prefix.

## Understand the design
- **Web subnet:** public IPv4 address on launch, default route to Internet Gateway, inbound TCP/80 permitted. No web server software is installed, so browsing the public IP will **not** display a website.
- **App subnet:** no internet route, inbound TCP/8080 allowed only from the web security group.
- **DB subnet:** no internet route, inbound TCP/3306 allowed only from the app security group. The EC2 instance is **not** an installed database.
- Every subnet also has the automatically provided VPC-local route. No NAT Gateway, load balancer, RDS, SSH ingress, or remote state is included.
- All instances are in one Availability Zone. This is an educational architecture, not a production design.

## Cleanup — required
```bash
terraform destroy
```

Review the plan, type `yes`, then confirm resources are gone in the AWS Console. EC2 instances and other resources can incur charges even in a lab account.

## Instructor's next step: variables (not included in starter code)
After the static lab works, demonstrate how to replace **one** literal (for example `"10.30.0.0/16"`) with a declared input variable and `var.vpc_cidr`. Let students make the change; keep the committed starter file static.
