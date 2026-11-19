# Automation Pipeline — GitHub Actions + Terraform

This folder combines the old **GitHub Actions** and **CI/CD Pipelines** sections into one beginner-friendly final project. The Terraform files remain **static**: no input variables, `locals`, `count`, `for_each`, or modules.

## What students will build

```text
Student edits Terraform
       |
       v
Push branch + open Pull Request
       |
       v
GitHub Actions: terraform fmt -check + terraform validate
       |
       v
Instructor reviews and merges
       |
       v
Actions > Week 3 Terraform Pipeline > Run workflow
       |
       v
GitHub OIDC -> AWS role -> S3 remote state -> terraform plan
       |
       v
Instructor chooses apply or destroy
```

The workflow lives at the **repository root**, where GitHub expects it: [`.github/workflows/week3-terraform.yml`](../../../../.github/workflows/week3-terraform.yml).

## Part 1 — Install tools

Use the [Windows Terraform guide](../../../../How-To/Windows/Terraform.md) or [macOS Terraform guide](../../../../How-To/macOS/Terraform.md), and the AWS CLI guides in the same `How-To` directory. Verify:

```bash
git --version
terraform version
aws --version
```

## Part 2 — Set up GitHub

1. Sign in to GitHub and open your **own fork or class repository**. Do not give students write access to the instructor's main branch.
2. Clone it: `git clone https://github.com/YOUR-USERNAME/YOUR-REPO.git`.
3. Open the repo and locate `Weekly-Lessons/Week 3 - Infrastructure as Code & Automation/infrastructure-as-code/terraform/`.
4. Create a new branch: `git checkout -b week3-terraform-lab`.
5. Make a small change to a tag in `main.tf` (keep it static).
6. Run `terraform fmt` locally; then `git add .`, `git commit -m "Practice Terraform pipeline"`, and `git push -u origin week3-terraform-lab`.
7. On GitHub, open a **Pull Request** to `main`. Click **Actions** to see the automatic formatting and validation checks. Fix any errors before merging.

**Important:** GitHub only detects Actions workflows from `.github/workflows/` at the repository root. Merely placing a YAML file in this lesson folder will not run it.

## Part 3 — Instructor AWS setup for optional deployment

The automatic pull-request checks **do not** need AWS credentials. Actual AWS deployment is **manual** and requires the following one-time instructor setup.

1. In a dedicated AWS lab account, create a **private S3 bucket** in `us-east-1` for Terraform state. Enable versioning, default encryption, and Block Public Access. Keep this bucket outside the Week 3 Terraform lab so `terraform destroy` cannot delete its own state.
2. In AWS IAM, create a GitHub **OIDC identity provider** with URL `https://token.actions.githubusercontent.com` and audience `sts.amazonaws.com`, if one does not already exist.
3. Create an IAM role for the workflow. In its trust policy restrict `token.actions.githubusercontent.com:aud` to `sts.amazonaws.com` and `token.actions.githubusercontent.com:sub` to **your exact GitHub repository and environment**: `repo:OWNER/REPO:environment:terraform-lab`. Do not use a wildcard for all GitHub repositories.
4. Attach a **lab-scoped** permissions policy that allows the necessary EC2/VPC/SSM operations and S3 access to only the state bucket and `week3/terraform.tfstate` (plus its `.tflock` object). Ask the instructor or cloud administrator to review this policy; avoid long-lived AWS access keys or granting administrator permissions to students.
5. In GitHub repository **Settings → Environments**, create an environment named `terraform-lab`. Configure required reviewers where supported by your plan and repository visibility. Restrict deployment branches as appropriate.
6. In GitHub **Settings → Secrets and variables → Actions → Variables**, create:
   - `AWS_ROLE_ARN`: the ARN of the IAM role from step 3
   - `TF_STATE_BUCKET`: your existing S3 state bucket name

The workflow uses GitHub OIDC to obtain short-lived AWS credentials. It generates an S3 backend configuration **only on the GitHub runner**. This keeps the committed student Terraform example simple and locally usable without remote-state setup.

**State warning:** Local Terraform and the pipeline use different state files. **Do not deploy the same lab from both locations.** If the lab was previously applied locally, destroy it locally before switching to pipeline deployment. If a pipeline deployment already exists, use the pipeline's `destroy` action to clean it up.

## Part 4 — Run the pipeline

1. Merge the validated PR to `main`.
2. Open **Actions → Week 3 Terraform Pipeline → Run workflow**.
3. Choose `apply`, select `main`, and start the workflow. Review the `check` and `deploy` job logs.
4. Verify the five subnets, two EC2 instances, and application URL in AWS. The app may take several minutes to initialize.
5. Run the same workflow again with `destroy` to clean up. Verify the resources are gone.

**Safety:** `apply` and `destroy` make real AWS changes and may incur charges. This workflow uses automatic approval **after** the manual workflow dispatch and any GitHub environment approval; it is for an isolated teaching account only. If your GitHub plan does not support required reviewers for this repository, the person who can run the workflow is the deployment gate.

## Student assignment

- Open a PR that changes one resource tag.
- Show a passing GitHub Actions `check` job.
- Explain the difference between `fmt`, `validate`, `plan`, and `apply`.
- Explain why OIDC is safer than storing permanent AWS keys.
- With instructor supervision, run `apply`, inspect AWS resources, and run `destroy`.
- Submit screenshots of the PR, checks, and deployment/cleanup logs. Never submit credentials, state files, or passwords.
