# Week 3 Assignment — Read, Build, Explain

Use the [static Terraform starter](../terraform/main.tf) and [guided lab](../labs/README.md).

## Deliverables
1. Screenshot or text output showing `terraform validate` succeeded.
2. Screenshot of `terraform plan` **before** applying.
3. Screenshot of the VPC and its three subnets after applying.
4. Screenshot of the three route tables showing that only the web route table has an Internet Gateway default route.
5. In your own words (2–3 sentences each): What is a resource? What does `aws_vpc.class_vpc.id` mean? Why is the database subnet private?
6. Screenshot or text output showing `terraform destroy` completed.

## Stretch task (only after class)
Change the VPC CIDR from a hardcoded string to a Terraform input variable. Keep the three subnet blocks separate. **Do not use loops, `count`, `for_each`, `locals`, or modules.**

## Submission
Submit screenshots and a short README with your answers. Do not submit AWS credentials, state files, or private keys. Destroy resources when finished.
