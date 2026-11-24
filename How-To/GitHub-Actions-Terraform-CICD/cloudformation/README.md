# GitHub Actions Terraform IAM Role — CloudFormation

Use this template to bootstrap the IAM role for the Terraform VPC lab without creating the role and policies manually.

## 1. Find your GitHub IDs using the GitHub REST API

No GitHub CLI installation is required. For a public repository, open these URLs directly in your browser or use curl.

### GitHub owner ID

Replace YOUR_USERNAME with your GitHub username or organization:

https://api.github.com/users/YOUR_USERNAME

Find the top-level numeric `id` field. Do not use `node_id`.

Instructor example: https://api.github.com/users/pyjoepy06

### GitHub repository ID

Replace YOUR_USERNAME and YOUR_REPOSITORY:

https://api.github.com/repos/YOUR_USERNAME/YOUR_REPOSITORY

Find the top-level numeric `id` field (repository ID). The nested `owner.id` is the owner ID.

Instructor example: https://api.github.com/repos/pyjoepy06/cloud-accelerator-experience

### Optional terminal commands

```bash
curl -fsSL https://api.github.com/users/YOUR_USERNAME
curl -fsSL https://api.github.com/repos/YOUR_USERNAME/YOUR_REPOSITORY
```

If jq is installed, retrieve only the IDs:

```bash
curl -fsSL https://api.github.com/users/YOUR_USERNAME | jq '.id'
curl -fsSL https://api.github.com/repos/YOUR_USERNAME/YOUR_REPOSITORY | jq '.id'
```

Private repositories require authenticated API access. Use a suitably scoped token stored securely in an environment variable, never in source control:

```bash
curl -fsSL -H "Authorization: Bearer $GITHUB_TOKEN" \
  https://api.github.com/repos/YOUR_USERNAME/YOUR_REPOSITORY
```

## 2. Prerequisites

- Existing IAM OIDC provider: token.actions.githubusercontent.com, audience sts.amazonaws.com.
- Existing S3 state bucket with versioning, encryption and public access blocked.
- GitHub repository and environments terraform-apply and terraform-destroy.
- Verify the actual OIDC subject format matches the template's owner@ID/repository@ID format. If your repository emits the conventional subject without numeric IDs, adjust the trust policy to match exactly. Do not use broad wildcards.
- Restrict both GitHub environments to the intended branch and configure required approvals where supported. Environment subjects do not independently enforce branch restrictions.
- The named IAM role must not already exist outside the stack.

## 3. CloudFormation parameters

| Parameter | Instructor example |
|---|---|
| TerraformStateBucket | cloud-accelerator-tfstate-948806324987 |
| TerraformStateKey | week3/terraform.tfstate |
| GitHubOwner | pyjoepy06 |
| GitHubOwnerId | 32583151 |
| GitHubRepository | cloud-accelerator-experience |
| GitHubRepositoryId | 1434882243 |
| GitHubBranch | main |
| GitHubApplyEnvironment | terraform-apply |
| GitHubDestroyEnvironment | terraform-destroy |

Use your own values, not the instructor's. The AWS account ID is automatically resolved.

## 4. Deploy

In the AWS CloudFormation console, create a stack, upload github-actions-terraform-role.yaml, enter your parameters, and acknowledge creation of named IAM resources.

Alternatively, from this directory:

```bash
aws cloudformation deploy \
  --template-file github-actions-terraform-role.yaml \
  --stack-name github-actions-terraform-role \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    TerraformStateBucket=YOUR_BUCKET_NAME \
    GitHubOwner=YOUR_USERNAME \
    GitHubOwnerId=YOUR_OWNER_ID \
    GitHubRepository=YOUR_REPOSITORY \
    GitHubRepositoryId=YOUR_REPOSITORY_ID
```

Copy GitHubActionsRoleArn from the stack Outputs into your workflow's role-to-assume setting. Ensure the Terraform backend bucket and key match the stack parameters.

## 5. Security and troubleshooting

The role attaches AmazonVPCFullAccess and scoped S3 state/lock permissions. It does not grant full EC2 deployment permissions. Do not attach AdministratorAccess to work around missing permissions. Add only the permissions required for your lab. A customer-managed KMS key may require additional permissions.

Keep untrusted pull-request validation credential-free. Protect branches and environments, and verify the OIDC audience and subject when troubleshooting STS access denied. Never print raw OIDC tokens.

This template does not create the OIDC provider, state bucket, or GitHub environment protections. It has not been deployment-tested. Delete the stack when the lab no longer needs the role; deleting it does not delete Terraform-managed resources or state.
