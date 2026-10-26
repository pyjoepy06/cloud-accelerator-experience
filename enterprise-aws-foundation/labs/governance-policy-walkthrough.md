# Guided Lab — AWS Governance and Access Decisions

**Format:** instructor-guided analysis. **Deployment:** not required. **Estimated AWS cost:** $0 when completed entirely as a paper/design exercise.

## Scenario

HarborPoint Financial Services needs separate Development, Test, and Production accounts and a Security account. Engineers access AWS through IAM Identity Center. The organization wants to prevent member-account administrators from stopping CloudTrail logging.

## Exercise

1. Sketch an AWS Organizations hierarchy with Security, Infrastructure, and Workloads OUs; place Development, Test, and Production accounts.
2. Define two Identity Center groups: CloudEngineers and SecurityAuditors. Map each to accounts and example permission sets.
3. Review [the sample SCP](../service-control-policies/deny-cloudtrail-stop-logging.json).
4. Evaluate: a member-account engineer has AdministratorAccess but calls `cloudtrail:StopLogging`. Predict the outcome and identify the policy layer responsible.
5. Compare with a permitted read-only action and explain why an SCP does not grant it.
6. Document a safe troubleshooting process without changing the production SCP.

## Validation checklist

- [ ] OU/account diagram completed
- [ ] Identity Center access matrix completed
- [ ] IAM allow versus SCP maximum permissions explained
- [ ] Explicit deny scenario explained
- [ ] Tradeoffs and assumptions documented

## Safety

Do not run StopLogging in a production account or modify client SCPs. Any optional hands-on test must use an authorized sandbox with an appropriate audit trail and cleanup plan.
