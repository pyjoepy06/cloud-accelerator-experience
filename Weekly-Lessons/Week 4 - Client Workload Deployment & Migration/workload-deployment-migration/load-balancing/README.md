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
