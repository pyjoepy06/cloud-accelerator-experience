# Client Scenario — Migration Discovery with AWS Transform

[Back to Week 3](../../README.md)

**Our Week 3 cheat code: AWS Transform.**

AWS Transform uses agentic AI to help assess, plan, and accelerate migrations and modernization. We will showcase it using a simulated RVTools inventory, then connect its output to the questions a cloud architect must ask a client.

## The client

A fictional company wants to move VMware workloads to AWS. Leadership says, “We want better resilience and lower costs.” The infrastructure team supplies an RVTools inventory, but application owners have not confirmed recovery targets, dependencies, migration strategies, deadlines, or budget.

Your role is to lead discovery and use AI-assisted analysis to inform a recommendation.

## Five core questions

| Topic | Ask the client |
| --- | --- |
| Why | Why migrate, and what measurable business outcome defines success? |
| RTO / RPO | How long can each application be unavailable, and how much data loss is acceptable? |
| 6 Rs | Should each application be rehosted, replatformed, repurchased, refactored/re-architected, retired, or retained—and why? |
| Timeline | What deadline, change windows, dependencies, and testing constrain migration? |
| Budget | What is approved for the migration and ongoing operation, including licenses and contingency? |

AWS also uses a 7 Rs model that adds Relocate. Use the six strategies above for this class exercise.

## Instructor showcase — RVTools to AWS Transform

**Format:** Instructor-led assessment and planning demonstration. No workload deployment or live migration is required.

1. Open the [50-VM simulated RVTools workbook](../requirements-gathering/Simulated_RVTools_50VM_Training_Lab.xlsx) and review the inventory with learners. The [150-VM and 500-VM files](../requirements-gathering/README.md) are optional examples of larger environments.
2. Open an authorized AWS Transform workspace and start the relevant assessment or VMware migration planning workflow.
3. Upload the simulated RVTools Excel file and review validation messages, recognized inventory, and missing fields.
4. Review the inventory summary and available assessment/planning outputs. Discuss compute recommendations, cost assumptions, and migration groupings or waves where the selected workflow and supplied data support them.
5. Ask learners to compare the output with the workbook and identify assumptions requiring client confirmation.
6. Return to the five core questions and record what the tool helped answer and what still requires discovery.
7. Summarize a proposed next step, supporting evidence, and an unresolved risk.

### Suggested prompts

- “Summarize this inventory and identify missing information needed for migration planning.”
- “What assumptions support these compute and cost recommendations?”
- “Suggest candidates for a low-risk pilot and explain what must be verified first.”
- “What additional data is needed to confirm application dependencies and migration waves?”

Capabilities and output depend on the selected workflow and available data. Do not present proposed groupings, cost estimates, or AI-generated explanations as verified application facts.

## Prepare before class

- Confirm workspace access, required identity/permissions, and workflow availability.
- Rehearse the upload with the exact synthetic file. AWS supports RVTools Excel and ZIP/CSV inputs, but these simulated RVTools-style workbooks have not been confirmed compatible with its importer.
- If validation fails, use the reported requirements and the official supported data template to prepare a compatible synthetic input before class. Do not rename a file extension to bypass validation.
- Keep screenshots or a recorded rehearsal as a clearly labeled fallback if upload or processing is delayed.
- Use only synthetic data. Do not upload client inventories without authorization.

## Free service versus migration costs

As checked November 9, 2026, AWS lists **assessment and the VMware migration agent at no service charge**. This does not make every AWS Transform feature or the resulting migration infrastructure free: custom transformations and continuous modernization have separate pricing, and AWS resources used for migration or operation can incur charges.

For this lesson, stay within the assessment/planning showcase. Students are not required to provision migration infrastructure. Confirm current pricing before class.

## Discussion and learner takeaway

Ask:

- “Can we promise a migration next month from this inventory alone?”
- “Can allocated VMware CPU/RAM establish sustained utilization?”
- “Who confirms application ownership, dependency groups, and recovery targets?”
- “How would we validate an AI-generated recommendation?”
- “What rollback and acceptance criteria belong in the pilot?”

**Takeaway:** AWS Transform accelerates analysis; the architect still validates evidence, clarifies business requirements, and explains tradeoffs.

Add a brief tool-assisted observation to your discovery notes: **what we learned, what remains unknown, and who must confirm it**. Continue using the [Week 3 assignment](../assignments/README.md).

Client answers introduced during role-play are fictional assumptions, not facts contained in the workbook.

## Official AWS resources

- [AWS Transform overview](https://aws.amazon.com/transform/)
- [AWS Transform pricing](https://aws.amazon.com/transform/pricing/)
- [Migration assessments](https://docs.aws.amazon.com/transform/latest/userguide/transform-app-assessments.html)
- [Migration assessment quick start](https://docs.aws.amazon.com/transform/latest/userguide/transform-app-assessments-quick-start.html)
- [Discover VMware source data and supported formats](https://docs.aws.amazon.com/transform/latest/userguide/transform-vmware-discover-source-data.html)
