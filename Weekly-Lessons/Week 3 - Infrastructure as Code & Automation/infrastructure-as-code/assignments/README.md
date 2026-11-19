# Week 3 Assignment

Using the [Terraform starter](../terraform/README.md), submit:
1. A successful `terraform validate` result.
2. A screenshot of the plan showing **two EC2 instances**.
3. A screenshot showing three subnets and their route tables.
4. The running HarborPoint page and `/customers` JSON.
5. A short explanation of `aws_subnet.app_subnet.id`, `aws_subnet.db_subnet.id`, and why the database security group allows MySQL only from the web security group.
6. Proof of `terraform destroy` cleanup.

**Optional live-class extension:** Replace one hardcoded CIDR with an input variable. Do not use `count`, `for_each`, loops, `locals`, or modules.
