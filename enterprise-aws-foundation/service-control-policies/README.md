# IAM Policies and Service Control Policies (SCPs)

## Key principles

- IAM policies can grant or deny permissions to principals, subject to the rest of AWS policy evaluation.
- SCPs define maximum available permissions for affected principals in member accounts; **SCPs never grant permissions**.
- Explicit deny overrides allow. An AdministratorAccess permission set cannot bypass an applicable SCP deny.
- SCPs do not restrict principals in the organization's management account and have exceptions such as service-linked roles. Resource policies, permission boundaries, and session policies can also affect authorization.

## Guided scenario

An engineer signs in using IAM Identity Center with an AdministratorAccess permission set but receives AccessDenied when attempting to stop CloudTrail logging. The organization's SCP explicitly denies `cloudtrail:StopLogging`.

**Explain:** The IAM role allows the API action, but the SCP sets a stricter maximum and denies it. Investigate the AWS error message, principal/account, and SCPs inherited through the account's OU hierarchy. Do not remove organizational controls simply to make the operation succeed.

## Examples

- [Illustrative SCP: deny stopping CloudTrail logging](deny-cloudtrail-stop-logging.json)
- [Guided policy walkthrough](../labs/governance-policy-walkthrough.md)

> The sample is intentionally narrow. Production CloudTrail protection requires additional controls, including governance around trail deletion, configuration changes, and access to logs.
