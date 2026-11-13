# Install Terraform — Windows

## Option A: Chocolatey

If Chocolatey is already installed, open an appropriate PowerShell terminal and run:

```powershell
choco install terraform -y
```

Close and reopen PowerShell, then verify:

```powershell
terraform version
Get-Command terraform
```

## Option B: Manual installation (no package manager)

1. Download the Windows ZIP matching your CPU architecture from [HashiCorp Terraform](https://developer.hashicorp.com/terraform/install).
2. Extract `terraform.exe` to a permanent directory, such as `C:\Tools\Terraform`.
3. Add that directory to your **user PATH** through Windows Settings → Environment Variables.
4. Open a **new PowerShell** window and run `terraform version`.

## Practice

```powershell
New-Item -ItemType Directory -Force "$HOME\terraform-practice"
Set-Location "$HOME\terraform-practice"
terraform version
```

Inside a downloaded class lab directory, run `terraform init`, `terraform fmt`, `terraform validate`, and `terraform plan`.

**Important:** `terraform apply` may create billable AWS resources. Only apply approved labs and clean up afterward. Never commit state files, `.terraform/`, or secrets.
