# Week 4 — Client Workload Deployment & Migration

Think like an Architect, build like an Engineer, communicate with confidence.

**Status: Planned instructor demonstration — pending instructor testing.** Exact OS images, networking, commands, and timing will be confirmed after rehearsal. No live migration or AWS deployment is required from students.

## This week's demonstration

The instructor will boot EC2 servers to **simulate an on-premises source environment**, install the **AWS Replication Agent**, and demonstrate the AWS Application Migration Service (MGN) rehosting lifecycle. Current AWS documentation may label the service AWS Transform MGN.

The sources are already EC2 instances used for training, not actual on-premises machines. Source and target resources will be clearly identified to avoid confusing a test launch with the source server.

## Learning goals

- Connect Week 3's Why, RTO/RPO, 6 Rs, Timeline, and Budget to migration decisions.
- Explain source servers, staging replication resources, and target EC2 instances.
- Describe agent installation, replication, test launch, validation, and cutover.
- Identify rollback conditions, application dependencies, operational ownership, and cleanup costs.

## Lesson materials

- [Compute](workload-deployment-migration/compute/README.md)
- [Storage](workload-deployment-migration/storage/README.md)
- [Databases](workload-deployment-migration/databases/README.md)
- [Load Balancing](workload-deployment-migration/load-balancing/README.md)
- [Migration Strategies](workload-deployment-migration/migration-strategies/README.md)
- [Planned MGN instructor demo](workload-deployment-migration/labs/README.md)
- [Assignment](workload-deployment-migration/assignments/README.md)

## From discovery to delivery

Week 3 used RVTools and AWS Transform for discovery and assessment. Week 4 focuses on agent-based server replication and the migration lifecycle through MGN. Inventory files are assessment inputs, not server disk replicas.

Use the demo to explain the process and collect evidence. A healthy replication status or a successful boot alone does not prove the application meets its recovery or acceptance requirements.
