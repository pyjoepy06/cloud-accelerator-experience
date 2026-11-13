# Install AWS CLI v2 — macOS

1. Open **Terminal**.
2. Download the official AWS installer and install it:

```bash
curl -fsSL https://awscli.amazonaws.com/AWSCLIV2.pkg -o AWSCLIV2.pkg
sudo installer -pkg AWSCLIV2.pkg -target /
```

3. Verify:

```bash
aws --version
which aws
```

The version should begin with `aws-cli/2`. If the command is not found, close and reopen Terminal.

## Connect to a lab account using IAM Identity Center

Use the SSO start URL and region supplied by your instructor:

```bash
aws configure sso --profile cloud-lab
aws sso login --profile cloud-lab
aws sts get-caller-identity --profile cloud-lab
```

Select the assigned AWS account and role during configuration. Never paste access keys into a repository.

**Troubleshooting:** If `aws` is not found, check `/usr/local/bin` is on your PATH. For installation issues, consult the [official AWS guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
