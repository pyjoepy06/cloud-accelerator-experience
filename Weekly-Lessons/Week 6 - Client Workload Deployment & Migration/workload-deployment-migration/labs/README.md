# Planned Instructor Demo — MGN with EC2 Source Servers

[Back to Week 4](../../README.md)

**Status: Planned instructor demonstration — pending instructor testing.** Exact OS images, networking, commands, and timing will be confirmed after rehearsal. Students use their own AWS accounts as migration destinations; detailed setup remains pending instructor testing.

## Scenario and boundaries

The instructor will launch EC2 source servers as stand-ins for on-premises machines. The AWS Replication Agent will be installed on these sources to demonstrate migration into target EC2 instances through MGN.

This is a controlled training simulation. It does not reproduce every physical-server, hypervisor, WAN, or data-center dependency. No real client workload or production cutover is involved.

## Proposed flow

1. Identify source servers, a simple application/test file, and the destination environment.
2. Explain replication settings, staging subnet, IAM roles, and target launch settings.
3. Install the AWS Replication Agent using the official procedure for the selected OS.
4. Observe source registration, initial synchronization, replication health, and lag.
5. Review target instance settings: subnet, security groups, instance type, storage, and access.
6. Launch a test instance when replication is ready.
7. Validate boot, application behavior, network access, and expected data.
8. Explain the cutover decision, final synchronization, traffic switching, acceptance, and rollback. A simulated cutover may be shown only after rehearsal.
9. Remove temporary resources and review remaining costs.

## Instructor rehearsal checklist

- Confirm supported OS, kernel, disks, available capacity, and agent prerequisites.
- Confirm account/Region boundaries and distinguish source, staging, test, and cutover resources with tags.
- Validate scoped installer permissions, service roles, and temporary credential handling. Never publish credentials in commands, screenshots, or the repository.
- Validate required HTTPS/service access and the source-to-replication data path, including TCP 1500, using the official networking requirements.
- Confirm administrative access to both source and target without broad public management rules.
- Use small disks and synthetic data. Measure initial replication and test-launch duration before class.
- Test application checks and a harmless file-change example.
- Record which steps actually succeeded and update this document after testing.

## Evidence and validation

Record source registration, replication health/lag, test launch status, application checks, and differences between source and target. Keep test workloads isolated to avoid duplicate scheduled jobs, conflicting identities, or unintended external integrations.

RTO/RPO are business targets; this classroom run is not proof that a production recovery target has been met.

## Costs and cleanup

Source EC2, replication/conversion resources, EBS volumes/snapshots, target instances, and supporting networking may incur charges. MGN service allowances do not make the infrastructure free. Review current pricing and clean up promptly.

After the demo, use the appropriate MGN lifecycle actions to stop replication and remove temporary staging resources. Separately verify termination of lab test/cutover and source instances and removal of leftover volumes, snapshots, public IPs, and lab-only networking. Archiving or disconnecting a source is not a substitute for checking target resources. Preserve shared infrastructure.

## Fallback

If the demo is not validated before class, use an architecture walkthrough and official documentation. If rehearsal succeeds but live replication is slow, show clearly labeled captured evidence. Do not describe untested steps as successful.

## AWS references

- [MGN user guide](https://docs.aws.amazon.com/mgn/latest/ug/what-is-application-migration-service.html)
- [Adding source servers and replication agent](https://docs.aws.amazon.com/mgn/latest/ug/adding-servers.html)
- [Network requirements](https://docs.aws.amazon.com/mgn/latest/ug/preparing-environments.html)
- [Post-migration lifecycle](https://docs.aws.amazon.com/mgn/latest/ug/server-post-migration.html)
- [MGN pricing](https://aws.amazon.com/application-migration-service/pricing/)

## Corrected lab topology — instructor sources to student accounts

The instructor creates a **separate source EC2 web server for each student**, simulating an on-premises workload. Each source is registered with MGN in its assigned student's destination account and Region. For this simple lab, staging replication resources and test/cutover instances live in that student account.

**Instructor account: source web server → student's MGN staging resources → student's target EC2 web server.**

This is a one-source-to-one-student mapping, not one installed agent simultaneously replicating one source into every account. Record the source instance, student alias, target account, Region, and MGN source-server ID before starting.

Students prepare their destination accounts and participate in target configuration and validation. The instructor owns source creation and agent installation. Use approved, scoped access and target-account installer authorization; never put credentials in user data, GitHub, or screenshots. Detailed IAM, networking, OS compatibility, and end-to-end replication remain pending rehearsal.

See the [web-server setup and validation guide](web-server-setup.md) for the basic page used by this exercise.
