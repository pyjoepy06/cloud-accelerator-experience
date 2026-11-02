# Guided Lab — AWS Governance, SCPs, and Access Decisions

**Format:** Instructor-guided analysis  
**Deployment:** Not required  
**Estimated AWS cost:** $0 when completed entirely as a paper/design exercise.  
**Duration:** 30–45 minutes

## Scenario

HarborPoint Financial Services is implementing AWS governance using AWS Organizations, IAM Identity Center, and Service Control Policies (SCPs).

The company operates four AWS accounts:

- **Security:** Centralized security monitoring and auditing.
- **Development:** Application development and testing.
- **Test:** Preproduction workload validation.
- **Production:** Business-critical applications.

Engineers access AWS accounts through IAM Identity Center.

The organization has established two security requirements:

### Requirement 1 — Protect CloudTrail in One Account

Prevent administrators and engineers from stopping or deleting CloudTrail logging in the **Production account**, even if they have `AdministratorAccess`.

### Requirement 2 — Restrict AWS Regions Organization-Wide

Deny regional AWS API operations outside these approved commercial US Regions:

- `us-east-1` — US East (N. Virginia)
- `us-east-2` — US East (Ohio)
- `us-west-1` — US West (N. California)
- `us-west-2` — US West (Oregon)

The restriction applies to member accounts throughout the organization, with carefully reviewed exceptions for global services.

## Exercise

### Part 1 — Design the AWS Organization

1. Sketch an AWS Organizations hierarchy containing:
   - Security OU
   - Infrastructure OU
   - Workloads OU
2. Place Security, Development, Test, and Production accounts into appropriate OUs.
3. Identify where each SCP should be attached:
   - **CloudTrail protection SCP:** Production account only.
   - **Region restriction SCP:** AWS Organizations root, affecting all member accounts beneath it.

### Part 2 — Configure IAM Identity Center Access

Define two IAM Identity Center groups:

| Group | Account | Example permission set |
|---|---|---|
| CloudEngineers | Development | AdministratorAccess |
| CloudEngineers | Test | PowerUserAccess |
| CloudEngineers | Production | ReadOnlyAccess |
| SecurityAuditors | All four accounts | ReadOnlyAccess or SecurityAudit, as appropriate |

Explain how permission sets grant access while SCPs establish maximum available permissions.

### Part 3 — Review the SCP Policies

**SCP 1 — Deny CloudTrail Modification**  
File: `deny-cloudtrail-stop-logging.json`

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DenyCloudTrailDisable",
      "Effect": "Deny",
      "Action": [
        "cloudtrail:StopLogging",
        "cloudtrail:DeleteTrail"
      ],
      "Resource": "*"
    }
  ]
}
```

**Attachment:** Production account only.

**SCP 2 — Restrict AWS Regions**  
File: `deny-non-us-regions.json`

Review the SCP that denies regional AWS API operations outside the four approved US Regions, with exceptions for required global services.

**Attachment:** AWS Organizations root.

### Part 4 — Evaluate Access Scenarios

For each scenario, predict the outcome and identify the responsible policy layer.

| Scenario | Expected result |
|---|---|
| Production administrator attempts `cloudtrail:StopLogging` | **Denied** by CloudTrail SCP |
| Development administrator attempts `cloudtrail:StopLogging` | Not blocked by the Production-only SCP; other permissions and policies still apply |
| Development engineer creates EC2 in `us-east-1` | Allowed **if** IAM and other controls permit |
| Development engineer creates EC2 in `eu-west-1` | **Denied** by Region SCP |
| Production administrator creates EC2 in `ap-southeast-1` | **Denied** by Region SCP |
| SecurityAuditor reads CloudTrail configuration | Allowed **if** IAM and other controls permit |

**Discussion questions:**

1. Why can't `AdministratorAccess` override an SCP?
2. Why does the CloudTrail SCP affect Production but not Development?
3. What happens if an administrator attempts to deploy resources in Europe?
4. Does an SCP grant permissions to IAM users or roles?
5. Why must global AWS services be considered when restricting Regions?

### Part 5 — Troubleshooting

An engineer receives `AccessDenied` while attempting to deploy an EC2 instance.

Document how you would:

1. Identify the denied AWS API action.
2. Verify the requested AWS Region.
3. Review the engineer's IAM Identity Center permission set.
4. Identify applicable SCPs inherited through the organization hierarchy.
5. Determine whether IAM permissions or an SCP caused the denial.
6. Recommend a resolution without weakening organization-wide security controls.

## Validation Checklist

- [ ] AWS Organizations OU/account diagram completed.
- [ ] IAM Identity Center access matrix completed.
- [ ] CloudTrail SCP assigned to Production only.
- [ ] Region restriction SCP assigned to the organization root.
- [ ] Approved US Regions identified.
- [ ] IAM permissions versus SCP restrictions explained.
- [ ] Explicit Deny behavior demonstrated.
- [ ] Access scenarios evaluated.
- [ ] Troubleshooting process documented.

## Safety

Do not stop CloudTrail logging in production accounts or modify client SCPs. Any optional hands-on testing must use authorized sandbox accounts with an appropriate audit trail and cleanup plan.

Test organization-wide SCP changes against AWS Control Tower, centralized logging, security services, and required global AWS service operations before deployment.

**Important:** SCPs do not restrict the AWS Organizations management account or service-linked roles. `aws:RequestedRegion` controls the AWS API endpoint receiving a request; it does not guarantee that all affected resources or data remain within approved Regions. This CloudTrail example protects only the two listed actions and is not a complete production hardening policy.

## Learning Outcomes

By completing this lab, students should be able to:

- Design an AWS multi-account hierarchy.
- Assign permissions through IAM Identity Center.
- Apply SCPs at account and organization-root scopes.
- Restrict AWS Regions.
- Protect critical security services.
- Troubleshoot access-denied errors.
