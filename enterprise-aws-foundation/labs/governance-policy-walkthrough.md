# Guided Lab — AWS Governance, SCPs, and Access Decisions

**Format:** Instructor-guided analysis  
**Deployment:** Not required  
**Estimated AWS cost:** $0 when completed entirely as a paper/design exercise  
**Duration:** 30–45 minutes

## Scenario

HarborPoint Financial Services is implementing AWS governance using AWS Organizations, IAM Identity Center, and Service Control Policies (SCPs).

The company operates four AWS accounts:

- **Security:** Centralized security monitoring and auditing.
- **Development:** Application development and testing.
- **Test:** Preproduction workload validation.
- **Production:** Business-critical applications.

Engineers access AWS accounts through IAM Identity Center.

The organization has established three security requirements.

### Requirement 1 — Protect CloudTrail in One Account

Prevent administrators and engineers from stopping or deleting CloudTrail logging in the **Production account**, even if they have `AdministratorAccess`.

### Requirement 2 — Restrict AWS Regions Organization-Wide

Deny regional AWS API operations outside these approved commercial US Regions:

- `us-east-1` — US East (N. Virginia)
- `us-east-2` — US East (Ohio)
- `us-west-1` — US West (N. California)
- `us-west-2` — US West (Oregon)

The restriction applies to member accounts throughout the organization, with carefully reviewed exceptions for global services.

### Requirement 3 — Urgent AI Governance: Restrict DeepSeek

**Fictional security incident scenario:** HarborPoint's Security Operations Center discovers that an engineer has been testing a **DeepSeek** model through Amazon Bedrock using synthetic prompts. Security leadership raises concerns about model-provider risk, regulatory obligations, and the possibility that sensitive customer information could be submitted to an AI model without approval.

Because DeepSeek is developed by a China-based company, HarborPoint's risk committee requests an immediate review of its use. **This scenario does not assert that DeepSeek caused a breach or that using a DeepSeek model through Amazon Bedrock automatically sends data to China.** Data handling depends on the service, model, Region, and contractual controls.

The CISO issues a temporary governance directive:

> **Block access to DeepSeek foundation models through Amazon Bedrock in every AWS member account while the organization completes its AI vendor-risk assessment. Continue allowing approved Bedrock models.**

Students must propose an SCP, decide where to attach it, and identify limitations and verification steps.

## Exercise

### Part 1 — Design the AWS Organization

1. Sketch an AWS Organizations hierarchy containing:
   - Security OU
   - Infrastructure OU
   - Workloads OU
2. Place Security, Development, Test, and Production accounts into appropriate OUs.
3. Identify where each SCP should be attached:
   - **CloudTrail protection SCP:** Production account only.
   - **Region restriction SCP:** AWS Organizations root, affecting member accounts beneath it.
   - **DeepSeek restriction SCP:** AWS Organizations root, affecting member accounts beneath it.
4. Explain why the management account is not governed by SCPs.

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

**SCP 3 — Restrict DeepSeek in Amazon Bedrock**  
Suggested file: `deny-bedrock-deepseek.json`

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DenyDeepSeekFoundationModels",
      "Effect": "Deny",
      "Action": "bedrock:*",
      "Resource": "arn:aws:bedrock:*::foundation-model/deepseek.*"
    }
  ]
}
```

**Attachment:** AWS Organizations root.

**Scope note:** This example denies Bedrock actions when the request authorizes against a matching DeepSeek foundation-model ARN. It is **not a comprehensive block** of all ways to use DeepSeek: cross-Region inference profiles, application inference profiles, provisioned throughput, imported/custom models, SageMaker deployments, and third-party APIs require separate assessment. Validate actual Bedrock authorization behavior for every supported inference path before treating the restriction as complete.

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
| Development administrator invokes a DeepSeek foundation-model ARN directly through Bedrock | **Denied** by DeepSeek SCP when the matching model ARN is authorized |
| Development administrator invokes an approved non-DeepSeek Bedrock foundation model in an approved Region | Not denied by the DeepSeek SCP; IAM and other controls still apply |
| Engineer invokes DeepSeek using a Bedrock inference profile | **Requires separate validation**; do not assume the sample SCP blocks every profile path |
| Engineer calls a third-party DeepSeek API from EC2 | **Not covered** by the Bedrock SCP; evaluate network/egress and application controls |

**Discussion questions:**

1. Why can't `AdministratorAccess` override an SCP?
2. Why does the CloudTrail SCP affect Production but not Development?
3. What happens if an administrator attempts to deploy resources in Europe?
4. Does an SCP grant permissions to IAM users or roles?
5. Why must global AWS services be considered when restricting Regions?
6. Why might a financial institution restrict an AI model provider pending security review?
7. Does blocking DeepSeek foundation-model ARNs automatically block inference profiles and external APIs?
8. How would you prove that approved Bedrock models remain usable while restricted models are blocked?

### Part 5 — Troubleshooting

An engineer receives `AccessDenied` while attempting to deploy an EC2 instance. Another engineer reports an authorization error when invoking a DeepSeek model through Bedrock.

Document how you would:

1. Identify each denied AWS API action and the caller identity.
2. Verify the requested AWS Region and Bedrock model or inference-profile identifier.
3. Review the engineers' IAM Identity Center permission sets and role permissions.
4. Identify applicable SCPs inherited through the organization hierarchy.
5. Determine whether IAM permissions, an SCP, or another control caused the denial.
6. Review relevant CloudTrail events without exposing sensitive prompts or customer data.
7. Recommend a resolution without weakening organization-wide security controls.
8. Test that approved model access still works and restricted invocation paths are denied in an authorized sandbox.

## Validation Checklist

- [ ] AWS Organizations OU/account diagram completed.
- [ ] IAM Identity Center access matrix completed.
- [ ] CloudTrail SCP assigned to Production only.
- [ ] Region restriction SCP assigned to the organization root.
- [ ] DeepSeek restriction SCP assigned to the organization root.
- [ ] Approved US Regions identified.
- [ ] IAM permissions versus SCP restrictions explained.
- [ ] Explicit Deny behavior demonstrated.
- [ ] DeepSeek model-provider risk and data-handling assumptions documented.
- [ ] Bedrock foundation-model versus inference-profile limitations identified.
- [ ] Access scenarios evaluated.
- [ ] Troubleshooting process documented.

## Safety

Do not stop CloudTrail logging in production accounts or modify client SCPs. Any optional hands-on testing must use authorized sandbox accounts with an appropriate audit trail and cleanup plan.

Test organization-wide SCP changes against AWS Control Tower, centralized logging, security services, required global AWS service operations, and supported Bedrock inference paths before deployment.

**Important:** SCPs do not restrict the AWS Organizations management account or service-linked roles. `aws:RequestedRegion` controls the AWS API endpoint receiving a request; it does not guarantee that all affected resources or data remain within approved Regions. The CloudTrail example protects only the two listed actions and is not a complete production hardening policy. The DeepSeek SCP is an instructional baseline, not a complete organization-wide AI model denylist.

## Learning Outcomes

By completing this lab, students should be able to:

- Design an AWS multi-account hierarchy.
- Assign permissions through IAM Identity Center.
- Apply SCPs at account and organization-root scopes.
- Restrict AWS Regions.
- Protect critical security services.
- Restrict selected Amazon Bedrock foundation models.
- Explain the limitations of SCP-based AI governance.
- Troubleshoot access-denied errors.
