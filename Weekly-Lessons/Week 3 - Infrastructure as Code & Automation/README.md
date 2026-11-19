# Week 3 — Infrastructure as Code & Automation

Start with the [static Terraform three-tier web application lab](infrastructure-as-code/terraform/README.md). The starter has explicit resource blocks and no input variables, modules, locals, count, or loops.

The lab deploys **two EC2 servers**: a Flask web server in the application-tier subnet and a MySQL server in the database-tier subnet. The third (web-tier) subnet is created but contains no server. For simple package installation without NAT charges, the app and DB subnets are internet-routed **lab-only** subnets; see the Terraform README for security and cost tradeoffs.

Then complete the [guided lab](infrastructure-as-code/labs/README.md) and [assignment](infrastructure-as-code/assignments/README.md). Introduce input variables live in class after students understand the static code.

Other topic introductions: [automation](infrastructure-as-code/automation/README.md), [GitHub Actions](infrastructure-as-code/github-actions/README.md), [CI/CD](infrastructure-as-code/cicd-pipelines/README.md), [CloudFormation](infrastructure-as-code/cloudformation/README.md).
