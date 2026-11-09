# Storage During Migration

[Back to Week 4](../../README.md)

## Focus

MGN replicates source disk data into staging resources and uses it to create target volumes. The planned demonstration uses synthetic data on EC2 source servers.

Discuss disk inventory, replication lag, encryption/KMS permissions, capacity, performance, snapshots, and target volume mapping. Review which data is actually on replicated disks versus external shares or services.

## Validation

Compare expected files and application data between source and target. Use checksums or application checks where appropriate. Do not assume disk replication guarantees application-consistent database recovery.

## Cost awareness

Staging volumes, target volumes, and retained snapshots can continue to incur costs. Include them in the [demo cleanup review](../labs/README.md).

No separate storage deployment is assigned.

## Corrected lab topology — instructor sources to student accounts

The instructor creates a **separate source EC2 web server for each student**, simulating an on-premises workload. Each source is registered with MGN in its assigned student's destination account and Region. For this simple lab, staging replication resources and test/cutover instances live in that student account.

**Instructor account: source web server → student's MGN staging resources → student's target EC2 web server.**

This is a one-source-to-one-student mapping, not one installed agent simultaneously replicating one source into every account. Record the source instance, student alias, target account, Region, and MGN source-server ID before starting.

Students prepare their destination accounts and participate in target configuration and validation. The instructor owns source creation and agent installation. Use approved, scoped access and target-account installer authorization; never put credentials in user data, GitHub, or screenshots. Detailed IAM, networking, OS compatibility, and end-to-end replication remain pending rehearsal.

See the [web-server setup and validation guide](../labs/web-server-setup.md) for the basic page used by this exercise.
