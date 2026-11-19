# Migration Strategies

[Back to Week 4](../../README.md)

## Connect to Week 3

Revisit Why, RTO/RPO, 6 Rs, Timeline, and Budget before selecting a migration method.

| Strategy | Meaning |
| --- | --- |
| Rehost | Move the workload with limited architectural change |
| Replatform | Make targeted platform changes |
| Repurchase | Replace with another product or SaaS |
| Refactor / Re-architect | Change the application architecture |
| Retire | Decommission an unneeded workload |
| Retain | Keep it in its current environment for now |

AWS also describes a seventh strategy, Relocate.

## This week's approach

The planned agent-based MGN showcase illustrates **rehosting**. EC2 source servers simulate on-premises machines; actual migration suitability and detailed procedure remain pending instructor testing.

Week 3's AWS Transform assessment helps inform decisions. MGN handles the demonstrated server replication and launch lifecycle. Neither replaces business approval or application validation.

## Migration gates

Scope agreed → prerequisites validated → replication healthy → test accepted → cutover approved → application accepted → migration finalized.

Define rollback and cleanup before starting. See the [demo plan](../labs/README.md).

## Corrected lab topology — instructor sources to student accounts

The instructor creates a **separate source EC2 web server for each student**, simulating an on-premises workload. Each source is registered with MGN in its assigned student's destination account and Region. For this simple lab, staging replication resources and test/cutover instances live in that student account.

**Instructor account: source web server → student's MGN staging resources → student's target EC2 web server.**

This is a one-source-to-one-student mapping, not one installed agent simultaneously replicating one source into every account. Record the source instance, student alias, target account, Region, and MGN source-server ID before starting.

Students prepare their destination accounts and participate in target configuration and validation. The instructor owns source creation and agent installation. Use approved, scoped access and target-account installer authorization; never put credentials in user data, GitHub, or screenshots. Detailed IAM, networking, OS compatibility, and end-to-end replication remain pending rehearsal.

See the [web-server setup and validation guide](../labs/web-server-setup.md) for the basic page used by this exercise.
