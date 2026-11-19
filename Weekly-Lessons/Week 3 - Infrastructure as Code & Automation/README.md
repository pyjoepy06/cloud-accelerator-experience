# Week 3 — Infrastructure as Code & Automation

**Start here:** [Terraform lesson](infrastructure-as-code/terraform/README.md) → [guided lab](infrastructure-as-code/labs/README.md) → [assignment](infrastructure-as-code/assignments/README.md).

## Goal
Learn to read, deploy, and safely destroy simple AWS infrastructure written in Terraform. We start with **literal values**, one resource block per resource, and no loops, `count`, `for_each`, `locals`, modules, or input variables.

## Architecture
- One VPC (`10.30.0.0/16`)
- Three subnets: public web (`10.30.1.0/24`), private application (`10.30.2.0/24`), private database (`10.30.3.0/24`)
- Three route tables, each explicitly associated with its subnet
- One Internet Gateway; only the web route table has a default route to it
- Three EC2 instances (one per tier) and three security groups

The application and database tiers are **infrastructure placeholders**, not a working web application or database. The private instances have no NAT or internet egress. This is a single-AZ teaching lab, **not** a production-ready highly available design.

## Class flow
1. What Terraform is; provider, resource, reference, state
2. Read `main.tf` together, one block at a time
3. Run `terraform init`, `fmt`, `validate`, `plan`, `apply`
4. Inspect the VPC, subnets, route tables, security groups, and instances in AWS
5. Introduce input variables **live**, after students understand static values
6. Run `terraform destroy` and confirm cleanup

## Sections
- [Terraform](infrastructure-as-code/terraform/README.md)
- [Labs](infrastructure-as-code/labs/README.md)
- [Assignments](infrastructure-as-code/assignments/README.md)
- [Automation](infrastructure-as-code/automation/README.md)
- [GitHub Actions](infrastructure-as-code/github-actions/README.md)
- [CI/CD pipelines](infrastructure-as-code/cicd-pipelines/README.md)
- [CloudFormation](infrastructure-as-code/cloudformation/README.md)

**Safety:** Use a dedicated AWS lab account, check costs, do not commit credentials or Terraform state, and destroy all lab resources afterward.
