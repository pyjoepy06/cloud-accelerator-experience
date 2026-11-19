# Database Migration Considerations

[Back to Week 4](../../README.md)

## Focus

The planned MGN demonstration is a server rehosting exercise, not a promise of database modernization or a separate managed-database migration.

A database hosted on a replicated server still requires application-consistency planning, supported configuration, recovery validation, and careful handling of writes during cutover.

## Discovery questions

- What engine/version, licensing, dependencies, and data volume are involved?
- What RTO/RPO and planned outage are approved?
- How will writes be quiesced, synchronized, and checked?
- Is rehosting appropriate, or should an engine-native process or database migration service be assessed?
- Who owns functional testing, backup/recovery validation, and rollback?

Do not run source and test databases against the same production integrations. No database service deployment is required for this conceptual section.

## Corrected lab topology — instructor sources to student accounts

The instructor creates a **separate source EC2 web server for each student**, simulating an on-premises workload. Each source is registered with MGN in its assigned student's destination account and Region. For this simple lab, staging replication resources and test/cutover instances live in that student account.

**Instructor account: source web server → student's MGN staging resources → student's target EC2 web server.**

This is a one-source-to-one-student mapping, not one installed agent simultaneously replicating one source into every account. Record the source instance, student alias, target account, Region, and MGN source-server ID before starting.

Students prepare their destination accounts and participate in target configuration and validation. The instructor owns source creation and agent installation. Use approved, scoped access and target-account installer authorization; never put credentials in user data, GitHub, or screenshots. Detailed IAM, networking, OS compatibility, and end-to-end replication remain pending rehearsal.

See the [web-server setup and validation guide](../labs/web-server-setup.md) for the basic page used by this exercise.
