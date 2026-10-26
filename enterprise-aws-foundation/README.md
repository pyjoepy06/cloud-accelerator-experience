# Enterprise AWS Foundation — Beta Cohort Session 1

**Tuesday, November 3, 2026 · 7:00–9:00 PM ET**

**Goal:** Understand how enterprises organize AWS accounts, provide workforce access, and enforce governance. This session prioritizes demonstrations and policy reasoning over deploying a full landing zone.

## Learning objectives

1. Explain the management account, member accounts, organizational units (OUs), and consolidated billing in [AWS Organizations](aws-organizations/README.md).
2. Explain [IAM Identity Center](iam-identity-center/README.md) users/groups, permission sets, and AWS account assignments.
3. Distinguish [IAM identity policies and SCPs](service-control-policies/README.md), including explicit deny and permission boundaries.
4. Recognize the roles of [AWS Control Tower](control-tower/README.md) and [Landing Zone Accelerator](landing-zone-accelerator/README.md) without deploying either.
5. Explain an AccessDenied scenario where AdministratorAccess is limited by an SCP.

## Two-hour instructor flow

| Time (ET) | Segment | Format |
| --- | --- | --- |
| 7:00–7:10 | Introduction and enterprise account strategy | Discussion |
| 7:10–7:30 | AWS Organizations: accounts, OUs, billing, policies | Instructor demonstration |
| 7:30–7:55 | IAM Identity Center: users, groups, permission sets, assignments | Instructor demonstration |
| 7:55–8:20 | IAM vs SCP evaluation, explicit deny, AccessDenied | Guided policy walkthrough |
| 8:20–8:45 | Control Tower and Landing Zone Accelerator | **Live-only, non-recorded, approved client demonstration** |
| 8:45–8:55 | Architecture decisions and questions | Discussion |
| 8:55–9:00 | Student assignment and submission expectations | Wrap-up |

## Client demonstration safeguards

The Control Tower/Landing Zone Accelerator segment is **instructor-only**. Students do not need client access, and the environment must not be reproduced in the repository. Obtain explicit approval for the audience and content shown. Stop meeting recording, transcription, AI meeting notes, and screenshots before opening the client environment. Resume recording only after closing client content. Mask or avoid customer identifiers, account IDs, resource names, internal networks, policies, security findings, and other sensitive details unless specifically approved. Use synthetic diagrams for any shareable recap.

## Labs and assignments

- [Guided governance lab](labs/governance-policy-walkthrough.md) — no Control Tower or LZA deployment required.
- [Student assignment](assignments/enterprise-foundation-assignment.md) — design an OU structure, explain identity access, and reason about IAM/SCP behavior.
- [SCP sample](service-control-policies/deny-cloudtrail-stop-logging.json) — illustrative training policy; test in a sandbox before use.

## Success criteria

A student can sketch a multi-account design, explain how workforce access reaches an AWS account, and diagnose an SCP explicit deny without confusing SCPs with grants of permission.
