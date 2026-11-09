# Network Security

## Learning goals

Apply least-privilege network access, distinguish routing from filtering, and communicate findings with evidence.

| Control | Role |
| --- | --- |
| Security group | Stateful resource/interface access rules; supports allow rules |
| Network ACL | Stateless subnet-boundary rules; supports allow/deny and requires return-traffic consideration |
| Route table | Chooses the destination path; does not replace access controls |
| Network firewall | Inspects routed traffic against configured security policy |

## Practical checks

- Identify the source, destination, protocol, port, and business justification.
- Restrict administrative access to approved sources.
- Check IPv4 and IPv6 rules where applicable.
- Confirm resource attachments, addresses, forward/return routes, and the listening service.
- An overly broad SG rule is a configuration concern; it does not alone prove internet reachability.

## Instructor AI showcase

The Bedrock network investigator demonstrates **Model → Tools → Permissions**:

- Bedrock requests an available tool.
- Python/Boto3 retrieves approved AWS inventory.
- IAM limits what the executing application can do.
- The model explains the returned evidence; the instructor verifies a finding manually.

Use read-only tools and sanitized data. Treat missing evidence as unknown, and do not claim remediation occurred unless it was explicitly executed and verified.

## Practice

Review the security groups in the [VPC assignment](../assignments/README.md). Explain why the private instance permits SSH from the public instance's security group and why NAT does not provide inbound management access.

For the architectural inspection discussion, see [Centralized Inspection](../centralized-inspection/README.md).

## References

- [Security groups](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-security-groups.html)
- [Network ACLs](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html)
- [Bedrock tool use](https://docs.aws.amazon.com/bedrock/latest/userguide/tool-use.html)

[Back to Week 2](../../README.md)
