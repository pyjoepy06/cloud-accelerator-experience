# Install AWS CLI v2 — Windows

1. Download the official [AWS CLI v2 Windows installer](https://awscli.amazonaws.com/AWSCLIV2.msi) and run it (administrator permission may be required).
2. Open a **new PowerShell** window.
3. Verify:

```powershell
aws --version
Get-Command aws
```

The version should begin with `aws-cli/2`.

If you cannot install for all users, try the official [current-user installer](https://awscli.amazonaws.com/AWSCLIV2-User.msi).

## Connect to a lab account using IAM Identity Center

Ask your instructor for the SSO start URL and region:

```powershell
aws configure sso --profile cloud-lab
aws sso login --profile cloud-lab
aws sts get-caller-identity --profile cloud-lab
```

Choose the assigned account and role. Do not share access keys or commit AWS credentials to GitHub.

**Troubleshooting:** Close and reopen PowerShell to refresh PATH. See [AWS installation documentation](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
