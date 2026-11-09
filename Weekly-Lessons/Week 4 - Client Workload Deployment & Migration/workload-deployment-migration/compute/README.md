# Compute Migration

[Back to Week 4](../../README.md)

**Status: Planned instructor demonstration — pending instructor testing.** Exact OS images, networking, commands, and timing will be confirmed after rehearsal. Students use their own AWS accounts as migration destinations; detailed setup remains pending instructor testing.

## Focus

The instructor's EC2 servers represent source machines. MGN replication and test/cutover launches produce separate target EC2 resources.

Review OS support, instance sizing, CPU architecture compatibility, IAM roles, management access, launch templates, security groups, and application startup behavior.

## Validation questions

- Does the target boot and pass EC2 status checks?
- Does the application start and answer a functional request?
- Are required dependencies and management paths available?
- Does sizing reflect measured needs rather than allocated source capacity alone?

See the [planned MGN demo](../labs/README.md). A successful EC2 launch is only one acceptance check.

## Corrected lab topology — instructor sources to student accounts

The instructor creates a **separate source EC2 web server for each student**, simulating an on-premises workload. Each source is registered with MGN in its assigned student's destination account and Region. For this simple lab, staging replication resources and test/cutover instances live in that student account.

**Instructor account: source web server → student's MGN staging resources → student's target EC2 web server.**

This is a one-source-to-one-student mapping, not one installed agent simultaneously replicating one source into every account. Record the source instance, student alias, target account, Region, and MGN source-server ID before starting.

Students prepare their destination accounts and participate in target configuration and validation. The instructor owns source creation and agent installation. Use approved, scoped access and target-account installer authorization; never put credentials in user data, GitHub, or screenshots. Detailed IAM, networking, OS compatibility, and end-to-end replication remain pending rehearsal.

See the [web-server setup and validation guide](../labs/web-server-setup.md) for the basic page used by this exercise.
