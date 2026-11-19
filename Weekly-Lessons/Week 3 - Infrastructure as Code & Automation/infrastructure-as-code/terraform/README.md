# Week 3: Static Terraform web application lab

Start with `main.tf` (VPC, three subnets, three route tables, routes and associations), then read `servers.tf` (two security groups, two EC2 instances). The supplied `.tftpl` files install a Flask web application and MySQL database.

- **Web application EC2** deploys to the **application-tier subnet** (`10.30.2.0/24`).
- **MySQL EC2** deploys to the **database-tier subnet** (`10.30.3.0/24`).
- The web-tier subnet (`10.30.1.0/24`) is left empty for teaching the three-subnet layout.
- No modules, `locals`, `count`, `for_each`, loops, or input variables. Literal CIDRs, region, instance types and ports are used.
- The AMI is looked up using `data "aws_ami"`; a `random_password` resource creates the database password rather than putting credentials in Git. Terraform state and EC2 user data still contain the password: **lab account only**.

## Important classroom networking compromise
To install packages via `apt` **without a costly NAT Gateway**, the app and database subnets have Internet Gateway routes and the instances receive public IPv4 addresses. The DB security group **does not permit inbound internet access**: port 3306 is allowed only from the web security group. These are **not production-private subnets**. A production design would keep the database private and provide controlled outbound access for bootstrapping. EC2 and public IPv4 addresses may incur charges.

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

Wait several minutes for user data to finish. Visit the web URL, `/health`, and `/customers`. If the app reports database unavailable, check EC2 user-data logs and allow MySQL initialization to complete.

## Assignment
1. Identify all three subnets and route tables in the AWS console.
2. Find the two EC2 instances and explain why the web EC2 is in the application tier.
3. Explain the security group rule allowing MySQL only from the web security group.
4. Capture the application page and `/customers` output.
5. Destroy the infrastructure and confirm cleanup.

**Do not commit** `.terraform/`, state files, credentials, or plans. Run this only in a disposable AWS training account.

## IAM role and SSM — compare two IaC formats

The separate [`IAM.tf`](IAM.tf) file creates a static EC2 IAM role, attaches the AWS-managed `AmazonSSMManagedInstanceCore` policy, and creates an instance profile. Both EC2 instances in [`servers.tf`](servers.tf) reference that instance profile.

Compare it with the [equivalent CloudFormation template](../cloudformation/ssm-ec2-role.yaml) and the [comparison guide](../cloudformation/README.md). **Do not deploy both examples together in the same AWS account**: they use the same fixed IAM names. IAM is global to the account, not scoped to a VPC.

The role enables SSM permissions, but SSM Session Manager also needs an active SSM Agent and network connectivity to SSM endpoints. Check the Ubuntu instance's SSM Agent status; IAM alone does not ensure connectivity. The classroom design's internet-routed subnets provide outbound connectivity, but agent installation/registration must still be verified.
