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
