# Week 3 — Infrastructure as Code & Automation

Start with the [static Terraform multi-AZ subnet lab](infrastructure-as-code/terraform/README.md). Students learn resource blocks and references before introducing input variables.

The example has **one VPC, five subnets across two Availability Zones, three route tables, and five route-table associations**. It deploys a Flask EC2 instance in the application subnet and a MySQL EC2 instance in the database subnet in AZ A. Additional web and database subnets in AZ B demonstrate the networking foundation for high availability; **the application and database are not yet highly available**.

## Install Terraform before class

**Windows (PowerShell):** If Chocolatey is installed, run:

```powershell
choco install terraform -y
terraform version
```

Otherwise download Terraform for Windows from [HashiCorp](https://developer.hashicorp.com/terraform/install), extract `terraform.exe`, add its folder to your user PATH, then open a new PowerShell window and run `terraform version`. [Full Windows instructions](../../How-To/Windows/Terraform.md).

**macOS (Terminal):** If Homebrew is installed, run:

```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
terraform version
```

Otherwise use the [official Terraform installer](https://developer.hashicorp.com/terraform/install). [Full macOS instructions](../../How-To/macOS/Terraform.md).

Also install the AWS CLI: [Windows](../../How-To/Windows/AWS-CLI.md) | [macOS](../../How-To/macOS/AWS-CLI.md). Confirm your AWS account with `aws sts get-caller-identity`.

## Class sequence

1. [Static Terraform and EC2 application](infrastructure-as-code/terraform/README.md)
2. [Guided Terraform lab](infrastructure-as-code/labs/README.md)
3. [Student assignment](infrastructure-as-code/assignments/README.md)
4. **Final project:** [Automation Pipeline — GitHub Actions + Terraform](infrastructure-as-code/automation-pipeline/README.md)

The final project combines the former GitHub Actions and CI/CD folders. Automatic GitHub checks run on PRs; AWS deployment is a separate, manual instructor-controlled step using OIDC and S3 remote state. No Terraform loops, `count`, `for_each`, `locals`, modules, or input variables are added.

Other introductions: [automation](infrastructure-as-code/automation/README.md) and [CloudFormation](infrastructure-as-code/cloudformation/README.md).

**Lab-only networking:** App and DB subnets have internet routes to support package installation without NAT. This is not a production-private database design. Destroy the lab when finished.
