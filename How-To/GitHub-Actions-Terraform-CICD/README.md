# GitHub Actions + Terraform CI/CD — Student How-To

This lab demonstrates a complete AWS Terraform pipeline: GitHub Actions validation, OIDC authentication, S3 remote state, plan, manually approved apply, and manually approved destroy.

## Files
- `terraform-cicd-template.yaml` — customize and copy to `.github/workflows/terraform-cicd.yaml`.
- `backend.tf.example` — copy to your Terraform working directory as `backend.tf`, replacing placeholders.
- `original-working-week3-workflow.yaml` — instructor's successfully tested workflow, retained for comparison.
- `Original-Instructor-Notes.md` — chronological instructor notes and troubleshooting.

## Customize these values
| Placeholder | Replace with |
|---|---|
| `YOUR_AWS_ACCOUNT_ID` | Your 12-digit AWS account number |
| `YOUR_AWS_REGION` | Region for the lab (for example `us-east-1`) |
| `YOUR_TERRAFORM_ROLE` | IAM role GitHub Actions may assume |
| `PATH_TO_TERRAFORM` | Relative path to your Terraform `.tf` files |
| `YOUR_UNIQUE_STATE_BUCKET` | Globally unique S3 bucket name |
| `YOUR_STATE_KEY` | State object key, e.g. `labs/terraform.tfstate` |
| `YOUR_GITHUB_OWNER/YOUR_REPO` | Repository owner and name for IAM trust |

## Step 1 — Create your workflow
In GitHub, open **Actions → New workflow → Set up a workflow yourself**. Store the workflow at `.github/workflows/terraform-cicd.yaml`. The triggers are pushes to `main`, pull requests targeting `main`, and manual `workflow_dispatch` with `plan`, `apply`, or `destroy` selections.

A **runner** is GitHub's temporary execution computer; a **job** groups steps; `uses:` runs a reusable action; `run:` executes a shell command.

## Step 2 — Create AWS OIDC provider and role
In AWS IAM → Identity providers, create OpenID Connect provider `https://token.actions.githubusercontent.com` with audience `sts.amazonaws.com`. Create a role for GitHub Actions with `sts:AssumeRoleWithWebIdentity` trust. Restrict `token.actions.githubusercontent.com:aud` to `sts.amazonaws.com` and `token.actions.githubusercontent.com:sub` to the exact authorized repository/ref and environment subjects.

For a typical default GitHub OIDC subject, `sub` is `repo:YOUR_GITHUB_OWNER/YOUR_REPO:ref:refs/heads/main`. For a job referencing a GitHub Environment, it is usually `repo:YOUR_GITHUB_OWNER/YOUR_REPO:environment:terraform-apply` or `...:terraform-destroy`. **Some organizations customize OIDC subject formats.** Verify the actual token claims instead of guessing. Protect the deployment environments and restrict deployments to `main`.

Give the workflow `permissions: id-token: write` and `contents: read`. Configure `aws-actions/configure-aws-credentials@v4` and test with `aws sts get-caller-identity`.

## Step 3 — Terraform checks
Install Terraform with `hashicorp/setup-terraform@v3`. Run `terraform version`, `terraform init`, `terraform fmt -check`, `terraform validate`, and `terraform plan -input=false -no-color`. Use `terraform fmt -recursive` locally if formatting fails.

## Step 4 — Remote state
Create a dedicated S3 bucket with versioning, encryption, and Block Public Access. Copy `backend.tf.example` to `backend.tf` and replace the bucket, key, and region. Use `use_lockfile = true` to coordinate Terraform state updates. The CI role needs `s3:ListBucket`, state object read/write, and lockfile read/write/delete permissions. Never commit local `.tfstate` files or secrets.

## Step 5 — IAM permissions
OIDC proves *who* the runner is; role permission policies determine *what* it can do. Plan needs read/describe permissions. Apply and Destroy need the actions required by the Terraform resources, including any `iam:PassRole` needed for EC2 instance profiles. The instructor temporarily used AdministratorAccess to finish the lab, then planned to remove it. **Do not use AdministratorAccess as a reusable student default.** Use a disposable sandbox and narrowly scoped deployment permissions.

## Step 6 — Manual approvals
In repository **Settings → Environments**, create `terraform-apply` and `terraform-destroy`. Configure required reviewers (if available on your plan) and limit deployment branches to `main`. Approval happens *before* the job's steps. The destroy command uses `-auto-approve` because a noninteractive runner cannot answer Terraform prompts; GitHub Environment review is the human gate.

## Step 7 — Test
1. Open a pull request and check Terraform formatting/validation/plan.
2. Run **Actions → Run workflow → apply** from `main`, approve the environment, and confirm infrastructure and the S3 state object.
3. Run **Actions → Run workflow → destroy** from `main`, approve, and confirm lab resources are removed.
4. Remove temporary elevated IAM access. The separately created S3 backend bucket is not removed by Terraform Destroy.

## Troubleshooting
- **AssumeRoleWithWebIdentity denied:** inspect `aud`, `sub`, provider ARN, role ARN, and trust policy. GitHub Environment jobs use different subjects than branch-only jobs; custom subject templates may include repository IDs.
- **AccessDenied during plan:** add only required read permissions.
- **AccessDenied during apply/destroy:** identify the exact missing action and resource; review IAM policies, conditions, and SCPs.
- **Backend initialization fails:** check bucket, region, key, lockfile permissions, and whether state bucket exists.
- **Approval doesn't appear:** verify Environment names, reviewer rules, repository plan, and deployment branch restrictions.
- **Manual plan selection:** the template's validation job runs for manual `plan`; Apply and Destroy run only when explicitly selected.

**Instructor note:** The original workflow ran the validation job on push, pull request, *and* manual dispatch, while the generic template limits AWS-authenticated validation to trusted push/manual events to avoid giving untrusted PR code privileged AWS credentials. Treat pull-request checks as untrusted input and separate no-credential formatting/validation from privileged planning when accepting outside contributors.
