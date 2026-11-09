# Compute Migration

[Back to Week 4](../../README.md)

**Status: Planned instructor demonstration — pending instructor testing.** Exact OS images, networking, commands, and timing will be confirmed after rehearsal. No live migration or AWS deployment is required from students.

## Focus

The instructor's EC2 servers represent source machines. MGN replication and test/cutover launches produce separate target EC2 resources.

Review OS support, instance sizing, CPU architecture compatibility, IAM roles, management access, launch templates, security groups, and application startup behavior.

## Validation questions

- Does the target boot and pass EC2 status checks?
- Does the application start and answer a functional request?
- Are required dependencies and management paths available?
- Does sizing reflect measured needs rather than allocated source capacity alone?

See the [planned MGN demo](../labs/README.md). A successful EC2 launch is only one acceptance check.
