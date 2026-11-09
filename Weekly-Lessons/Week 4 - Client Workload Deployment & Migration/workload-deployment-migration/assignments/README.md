# Assignment — Plan and Validate a Server Migration

[Back to Week 4](../../README.md)

**Format:** Instructor-demo observation and migration planning. No paid student deployment required.

The instructor plans to install the AWS Replication Agent on EC2 servers simulating on-premises sources. The detailed demo remains pending instructor testing.

## Tasks

1. Use your Week 3 requirements to select a hypothetical rehost candidate.
2. Draw source → staging/replication → target EC2, including management and application access.
3. Record prerequisite checks, target settings, and application dependencies.
4. Define test-launch acceptance checks, cutover approval, rollback triggers, and cleanup.
5. After the demo, record observed evidence separately from planned or untested steps. If a live demo is unavailable, use the architecture discussion and label evidence as proposed.

## Submit

- One-page migration runbook with owners and decision gates.
- A simple migration diagram.
- At least five validation checks, including application function and data verification.
- A cost/cleanup checklist and a short client-facing recommendation.

## Success criteria

The plan covers RTO/RPO and cutover downtime separately, identifies source/staging/target roles, justifies rehosting, defines measurable acceptance and rollback criteria, and distinguishes observed facts from assumptions.

Carry these artifacts into the operations lesson and capstone. Do not submit credentials or real client data.
