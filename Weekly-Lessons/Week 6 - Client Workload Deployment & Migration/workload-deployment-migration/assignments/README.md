# Assignment — Plan and Validate a Server Migration

[Back to Week 4](../../README.md)

**Format:** Instructor-demo observation and migration planning. Students use their own AWS accounts; migration resources can incur charges.

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

## Corrected lab topology — instructor sources to student accounts

The instructor creates a **separate source EC2 web server for each student**, simulating an on-premises workload. Each source is registered with MGN in its assigned student's destination account and Region. For this simple lab, staging replication resources and test/cutover instances live in that student account.

**Instructor account: source web server → student's MGN staging resources → student's target EC2 web server.**

This is a one-source-to-one-student mapping, not one installed agent simultaneously replicating one source into every account. Record the source instance, student alias, target account, Region, and MGN source-server ID before starting.

Students prepare their destination accounts and participate in target configuration and validation. The instructor owns source creation and agent installation. Use approved, scoped access and target-account installer authorization; never put credentials in user data, GitHub, or screenshots. Detailed IAM, networking, OS compatibility, and end-to-end replication remain pending rehearsal.

See the [web-server setup and validation guide](../labs/web-server-setup.md) for the basic page used by this exercise.
