# Automation Pipeline — Build GitHub Actions Manually

**Instructor-led final project. No pipeline workflow is pre-created.** We will build it together in GitHub, one step at a time. The student Terraform remains static: no loops, `count`, `for_each`, `locals`, modules, or input variables.

## What we'll learn

1. Create the workflow file manually in GitHub.
2. Run `terraform fmt -check` and `terraform validate` when code changes.
3. Set up AWS authentication using GitHub OIDC.
4. Configure an S3 bucket for Terraform remote state.
5. Add `terraform plan`, then a manual deployment workflow with `terraform apply`.
6. Add a safe manual `terraform destroy` and verify cleanup.

## Lesson 1 — Create your first GitHub Actions workflow (no AWS access required)

1. Open your GitHub repository.
2. Select **Actions** and choose **set up a workflow yourself** if offered, or select **Add file → Create new file** from the Code tab.
3. Name the file `.github/workflows/week3-terraform.yml`. GitHub Actions only recognizes workflow files in the repository-root `.github/workflows/` folder.
4. **During class**, type the following starter YAML yourself:

```yaml
name: Week 3 Terraform Checks

on:
  push:
  pull_request:

permissions:
  contents: read

jobs:
  terraform-check:
    runs-on: ubuntu-latest
    defaults:
      run:
        working-directory: 'Weekly-Lessons/Week 3 - Infrastructure as Code & Automation/infrastructure-as-code/terraform'
    steps:
      - name: Download repository
        uses: actions/checkout@v4

      - name: Install Terraform
        uses: hashicorp/setup-terraform@v3

      - name: Terraform Init
        run: terraform init -backend=false

      - name: Terraform Format
        run: terraform fmt -check

      - name: Terraform Validate
        run: terraform validate
```

5. Commit the new workflow on a class practice branch, open a pull request, and click **Actions** to watch the job run.
6. If the formatting check fails, run `terraform fmt` locally in the Terraform directory, commit the formatted files, and push again.
7. Click each job step and explain its purpose: checkout downloads code, setup installs Terraform, init downloads providers, fmt checks style, validate checks configuration.

**Stop here for the first demonstration.** No AWS credentials, state bucket, IAM role, or deployed infrastructure are needed to run these checks.

## Lesson 2 — AWS access with OIDC (after Lesson 1 works)

1. In a dedicated AWS lab account, create an IAM OIDC identity provider for `https://token.actions.githubusercontent.com` with audience `sts.amazonaws.com` (if it does not already exist).
2. Create a role that trusts **only** your specific GitHub repository and protected environment, using `token.actions.githubusercontent.com:aud` and `token.actions.githubusercontent.com:sub` conditions.
3. Give the role only the permissions necessary for this isolated Terraform lab and its S3 state. Do not use permanent access keys.
4. Create a GitHub environment named `terraform-lab` and configure required reviewers if supported by your repository and plan.
5. Set GitHub Actions variable `AWS_ROLE_ARN` to the role ARN.
6. Later, add the `aws-actions/configure-aws-credentials@v4` step and `id-token: write` permission **only to the deployment job**.

## Lesson 3 — S3 remote state

1. Create a separate private S3 bucket in `us-east-1`; enable versioning, encryption, and Block Public Access.
2. Give the deployment role scoped access to the state object and its lock file.
3. Configure the S3 backend and `use_lockfile = true` during the guided deployment lesson. Do not add backend configuration to the beginner starter until ready.
4. **Never mix local and pipeline state for the same resources.** Destroy any local lab before switching to the pipeline.

## Lesson 4 — Plan, apply, and destroy

After OIDC and S3 work, add `terraform plan` to the deployment job. Then configure a **manual** GitHub Actions trigger (`workflow_dispatch`) for `apply` and `destroy`, with environment approval where available. Review the plan before running the apply step. Deploy only to a disposable AWS training account; confirm the resources in AWS and then run destroy.

**Safety:** GitHub Actions permissions, IAM trust policies, state access, and workflow approvals must be reviewed before enabling deployment. EC2 instances and public IPv4 addresses can incur charges. Never commit secrets, Terraform state, or private keys.

## Student assignment

- Create the workflow YAML yourself.
- Explain what `checkout`, `setup-terraform`, `init`, `fmt`, and `validate` do.
- Show a passing GitHub Actions check.
- After instructor approval, extend the workflow with AWS OIDC, remote state, plan, apply, and destroy.
- Capture the workflow logs and evidence of resource cleanup.
