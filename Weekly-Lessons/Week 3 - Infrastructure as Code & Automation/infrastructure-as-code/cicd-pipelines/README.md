# CI/CD Pipelines — Concept Only

A pipeline runs repeatable checks and deployment steps. For Week 3, focus on understanding this sequence:

```text
Edit Terraform -> terraform fmt -> terraform validate -> terraform plan -> human review -> terraform apply
```

Students run these steps **manually** in the [guided lab](../labs/README.md). We will not set up automated `apply`, remote state, OIDC, or deployment approvals in this beginner exercise.
