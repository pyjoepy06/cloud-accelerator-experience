# Week 3 — Infrastructure as Code & Automation

Start with the [static Terraform multi-AZ subnet lab](infrastructure-as-code/terraform/README.md). Students learn resource blocks and references before introducing input variables.

The example has **one VPC, five subnets across two Availability Zones, three route tables, and five route-table associations**. It deploys a Flask EC2 instance in the application subnet and a MySQL EC2 instance in the database subnet in AZ A. Additional web and database subnets are created in AZ B to illustrate how AWS architecture spans AZs.

**Teaching distinction:** Subnets in two AZs are the foundation for HA, but the application and database are **not yet highly available**. This class does not add load balancers, Auto Scaling, database replication, or failover.

Next: [guided lab](infrastructure-as-code/labs/README.md) and [assignment](infrastructure-as-code/assignments/README.md). The example stays static with no `count`, `for_each`, loops, `locals`, modules, or input variables.

For package installation without NAT charges, the app and DB subnets use internet routing in this **lab-only** design; see the Terraform README for the limitations.

Other topics: [automation](infrastructure-as-code/automation/README.md), [GitHub Actions](infrastructure-as-code/github-actions/README.md), [CI/CD](infrastructure-as-code/cicd-pipelines/README.md), [CloudFormation](infrastructure-as-code/cloudformation/README.md).
