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
