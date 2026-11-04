# Assignment — Design an Enterprise AWS Foundation

**Scenario:** HarborPoint Financial Services is moving to AWS. It needs Development, Test, and Production isolation, centralized security, and consistent employee access.

## Deliverables

1. **Organizations diagram:** show a management account, proposed OUs, and at least four member accounts. Explain your OU design.
2. **Identity access matrix:** define at least two workforce groups, the accounts each can access, and appropriate permission sets.
3. **IAM example:** provide a sample read-only IAM policy scoped to a selected AWS service or set of resources, and explain what it permits.
4. **SCP analysis:** review the provided CloudTrail StopLogging deny example and explain its effect on member-account principals.
5. **Troubleshooting response:** an engineer with AdministratorAccess is denied `cloudtrail:StopLogging`. Describe the cause and investigation steps.
6. **Architecture reflection:** explain where Control Tower and Landing Zone Accelerator could fit into the design without deploying either.

## Submission

Submit a link to your own GitHub portfolio repository with `README.md`, a diagram, a sanitized policy example, and a short `design-decisions.md`. Do not include credentials, client screenshots, customer details, or Terraform state.

## Evaluation (100 points)

| Area | Points |
| --- | ---: |
| OU/account design and reasoning | 25 |
| Identity Center access matrix | 20 |
| IAM/SCP policy reasoning | 25 |
| AccessDenied troubleshooting | 20 |
| Documentation and communication | 10 |

**Completion:** A student can justify a multi-account design and explain why an IAM allow does not defeat an SCP deny.
