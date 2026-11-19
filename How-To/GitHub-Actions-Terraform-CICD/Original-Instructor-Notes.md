# Instructor deployment notes — chronological recap

This companion is a concise, generalized transcription of the steps and troubleshooting from the successful class lab. The original detailed notes were supplied as `GitHub-CI-CD-Setup.md` and are also available in the previously generated downloadable instructor package.

1. Open GitHub Actions and choose **Set up a workflow yourself**.
2. Start with `push` and `pull_request` triggers for `main`. Introduce event, job, runner, step, `uses`, and `run`.
3. Install Terraform; add `terraform version`, `terraform init -backend=false`, `terraform fmt -check`, and `terraform validate`.
4. In AWS IAM, create GitHub OIDC provider `https://token.actions.githubusercontent.com` with audience `sts.amazonaws.com`; create `GitHubActions-Terraform-Role`.
5. Add `id-token: write` and `contents: read`, configure AWS credentials action, and verify identity with `aws sts get-caller-identity`.
6. Troubleshoot OIDC: the working repository used an ID-based customized subject (`repo:OWNER@OWNER_ID/REPO@REPO_ID:ref:refs/heads/main`) instead of the typical name-based subject. Inspect the JWT claims rather than assuming a format. Never print the raw token.
7. Create an encrypted, versioned S3 state bucket with Block Public Access; add S3 state/lockfile IAM permissions. Enable `backend.tf` with `use_lockfile = true`.
8. Add Terraform Plan. Read-only EC2 Describe permissions were needed to inspect infrastructure.
9. Add `workflow_dispatch` with `plan`, `apply`, and `destroy` choices.
10. Create GitHub Environments `terraform-apply` and `terraform-destroy`, with reviewer approval and branch restrictions.
11. Add Apply job: checkout → Terraform setup → OIDC → init → `plan -out=tfplan` → `apply tfplan`.
12. Add Destroy job: checkout → Terraform setup → OIDC → init → `destroy -auto-approve`, after environment approval.
13. Environment-based OIDC subjects differ from branch-based subjects; include only the exact verified subjects in IAM trust.
14. IAM deployment policies for VPC, subnets, routes, IGW, security groups, EC2, and instance profiles proved more involved than expected. Instructor temporarily used AdministratorAccess in a sandbox to complete the deployment, then planned to remove it.
15. Apply and Destroy both completed successfully. Confirm state remains in S3 and clean up privileged access after the lab.

## Teaching themes
**Translate → Implement → Demonstrate.** Identity trust vs authorization; infrastructure as code; CI vs CD; remote state and locking; manual approvals; and why troubleshooting real IAM errors is part of cloud engineering.
