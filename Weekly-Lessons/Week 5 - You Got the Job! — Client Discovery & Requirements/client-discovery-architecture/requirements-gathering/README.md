# Requirements Gathering

[Back to Week 3](../../README.md)

## Five core migration questions

| Topic | Ask the client | Capture |
| --- | --- | --- |
| Why | Why are we migrating, and what business outcome defines success? | Drivers, current pain, measurable outcomes, sponsor, and scope |
| RTO / RPO | How long can each application be unavailable, and how much data can be lost? | RTO (maximum acceptable recovery time), RPO (maximum acceptable data-loss window), business owner approval, cutover downtime, and recovery validation |
| 6 Rs | Which migration strategy fits each application, and why? | Rehost, Replatform, Repurchase, Refactor/Re-architect, Retire, or Retain; rationale and dependencies |
| Timeline | When must migration finish, and what constrains the schedule? | Hard deadlines, migration waves, change freezes, testing, cutover windows, rollback time, and owners |
| Budget | What can we spend to migrate and operate the solution? | One-time migration costs, recurring cloud costs, licenses, connectivity, support, training, contingency, and approval owner |

Use the requested **6 Rs** for this exercise. AWS also describes a **7 Rs** model that adds Relocate. Do not select a strategy from VM size alone. Recovery targets and planned cutover downtime are related requirements that should be recorded separately.

## Simulated RVTools workbooks

All three workbooks contain **synthetic training data**, not a real client's infrastructure. Choose one dataset; you do not need to assess all three.

| Dataset | Suggested use |
| --- | --- |
| [50 VMs](Simulated_RVTools_50VM_Training_Lab.xlsx) | Start here for the core assignment |
| [150 VMs](Simulated_RVTools_150VM_VMware_Assessment.xlsx) | Additional assessment practice |
| [500 VMs](Simulated_RVTools_500VM_VMware_Assessment.xlsx) | Larger inventory and wave-planning practice |

Review the available VM, OS, CPU, memory, disk, host, cluster, storage, and networking tabs. Summarize what the workbook actually shows and reference the supporting tab/column.

An inventory snapshot does not establish application dependencies, sustained utilization, business criticality, licensing eligibility, migration compatibility, or recovery requirements. Record these as follow-up questions rather than inventing answers. Do not equate provisioned capacity with measured consumption.

## Capture requirements

Use this table in your notes:

| Application / service | Owner | Business outcome | Dependencies | RTO | RPO | Cutover downtime | Proposed R | Deadline | Budget | Evidence / open questions |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| To discover | TBD | TBD | TBD | TBD | TBD | TBD | TBD | TBD | TBD | Workbook reference or client response |

Group VMs into applications only where evidence supports the grouping; label name-based groupings as hypotheses. Mark unknowns as **TBD**, assign an owner, and document the next validation step.

## References

- [AWS migration strategies — 7 Rs](https://docs.aws.amazon.com/prescriptive-guidance/latest/large-migration-guide/migration-strategies.html)
- [AWS Well-Architected Reliability Pillar](https://docs.aws.amazon.com/wellarchitected/latest/reliability-pillar/welcome.html)
