# Hybrid Connectivity

**Format:** Conceptual discussion; no VPN or Direct Connect deployment required.

## Learning goals

Identify requirements for connecting on-premises networks and users to AWS, and explain connectivity tradeoffs.

| Option | Typical purpose | Questions to ask |
| --- | --- | --- |
| Site-to-Site VPN | IPsec connectivity between networks | What bandwidth, tunnel resilience, and routing are required? |
| Direct Connect | Dedicated private connectivity to AWS | What lead time, capacity, resilient connections, and encryption are needed? |
| Client VPN | Remote-user access | Which identities, endpoints, routes, and authorization rules apply? |

Do not treat a private connection as proof of encryption. Evaluate encryption requirements separately.

## Trace the complete path

On-premises host → customer network → VPN/DX connectivity → AWS routing → target subnet → target application.

Validate return routing, non-overlapping CIDRs, DNS resolution, security controls, and application availability. A network connection alone does not resolve names or grant application access.

## Scenario

A company needs an on-premises application to reach a private AWS database. Ask for latency, availability, throughput, DNS, security, budget, and delivery deadlines before selecting connectivity.

**Student takeaway:** Recommend an initial approach and explain its limitations and failover requirements. Use a diagram; no paid deployment is assigned.

## References

- [AWS VPN connectivity options](https://docs.aws.amazon.com/vpc/latest/userguide/vpn-connections.html)
- [Direct Connect documentation](https://docs.aws.amazon.com/directconnect/latest/UserGuide/Welcome.html)

[Back to Week 2](../../README.md)
