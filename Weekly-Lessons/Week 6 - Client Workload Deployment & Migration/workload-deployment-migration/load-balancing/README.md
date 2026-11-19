# Load Balancing and Migration Cutover

[Back to Week 4](../../README.md)

## Focus

A migrated server must receive the intended traffic only after validation and approval. Depending on the application, cutover may involve DNS, load-balancer targets, or another application entry point.

## Discussion

- Validate target health-check protocol, port, path, security rules, and application readiness.
- Test the target independently before directing users to it.
- Plan traffic switching, DNS caching/TTL where relevant, and observation periods.
- Define rollback triggers and how data written after cutover would be handled.
- Assign application acceptance and traffic-switching ownership.

The [MGN demo](../labs/README.md) will explain these decisions. A separate paid load balancer deployment is not required, and an automated traffic switch is not assumed.

## Corrected lab topology — instructor sources to student accounts

The instructor creates a **separate source EC2 web server for each student**, simulating an on-premises workload. Each source is registered with MGN in its assigned student's destination account and Region. For this simple lab, staging replication resources and test/cutover instances live in that student account.

**Instructor account: source web server → student's MGN staging resources → student's target EC2 web server.**

This is a one-source-to-one-student mapping, not one installed agent simultaneously replicating one source into every account. Record the source instance, student alias, target account, Region, and MGN source-server ID before starting.

Students prepare their destination accounts and participate in target configuration and validation. The instructor owns source creation and agent installation. Use approved, scoped access and target-account installer authorization; never put credentials in user data, GitHub, or screenshots. Detailed IAM, networking, OS compatibility, and end-to-end replication remain pending rehearsal.

See the [web-server setup and validation guide](../labs/web-server-setup.md) for the basic page used by this exercise.
