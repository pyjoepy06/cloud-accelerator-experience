# Week 3 Assignment — Static Multi-AZ Subnets

Using the [Terraform starter](../terraform/README.md), submit:

1. A successful `terraform validate` result.
2. A screenshot of the plan showing **five subnets and two EC2 instances**.
3. A screenshot of all five subnets and their Availability Zones.
4. A screenshot showing the three route tables and the five subnet associations.
5. The running HarborPoint page and `/customers` JSON.
6. Two short answers: Why can subnets in different AZs use the same route table? Why does adding a second database subnet **not** make MySQL highly available?
7. Proof of `terraform destroy` cleanup.

**Optional instructor-led extension:** Replace one hardcoded CIDR with an input variable. Do not use `count`, `for_each`, loops, `locals`, or modules.
