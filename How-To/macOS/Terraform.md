# Install Terraform — macOS

## Recommended: Homebrew

If Homebrew is installed, run in Terminal:

```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
terraform version
```

If Homebrew is not installed, follow the [official Terraform manual installation](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) for your Mac's Apple Silicon or Intel architecture, then place the `terraform` executable on your PATH.

## Try Terraform without creating cloud resources

```bash
mkdir -p ~/terraform-practice
cd ~/terraform-practice
terraform version
```

For class labs, run `terraform init`, `terraform fmt`, `terraform validate`, and `terraform plan` inside the lab directory after downloading its configuration.

**Important:** `terraform apply` may create billable AWS resources. Only apply an instructor-approved lab, and destroy resources when instructed. Never commit `.tfstate`, `.terraform/`, or secret `.tfvars` files.
