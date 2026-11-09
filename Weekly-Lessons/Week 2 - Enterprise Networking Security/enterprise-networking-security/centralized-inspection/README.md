# Centralized Inspection — How It Works

**Format:** Architecture discussion and instructor explanation. No deployment required.

> This is a conceptual lesson, not a build lab. Firewalls, endpoints, Transit Gateway attachments, appliances, logging, and data processing can make a short-lived deployment costly. Students should use the diagrams and AWS references below instead of deploying this architecture.

## Why centralize inspection?

An enterprise may have application VPCs across many accounts. Instead of operating an independent firewall stack in every VPC, it can steer selected traffic through a centrally managed inspection service.

The networking team owns traffic paths, while the security team manages inspection policy and reviews logs. Workload teams still own application access and security groups.

**Centralized inspection only sees traffic routed through it.** Sharing or attaching a Transit Gateway does not automatically inspect traffic.

## Main components

| Component | Role |
| --- | --- |
| Workload / spoke VPCs | Host applications in separate accounts or environments |
| Transit Gateway (TGW) | Connects networks and selects the next attachment using its route tables |
| Inspection VPC | In the traditional pattern, hosts firewall endpoints or appliance connectivity |
| AWS Network Firewall | Managed network firewall that evaluates traffic against configured rules |
| Gateway Load Balancer (GWLB) | Distributes traffic to compatible third-party inspection appliances; GWLB itself is not a firewall |
| Route tables | Steer traffic through inspection and onward to its destination |
| Logs | Provide evidence of allowed, rejected, or alerted traffic, depending on configuration |

AWS also supports Network Firewall attached directly to TGW. The inspection VPC pattern below is one architecture option, not a requirement for every centralized design.

## Example: private VPC-to-VPC inspection

A company wants traffic between an application VPC and a database VPC inspected.

1. The application subnet routes the database CIDR to TGW.
2. The TGW route table associated with the application attachment steers that destination to inspection.
3. Routing inside the inspection path sends the traffic through the firewall.
4. Allowed traffic returns to TGW through the inspection attachment.
5. The TGW route table associated with the inspection attachment sends it to the database VPC.
6. The response follows the corresponding inspection path in reverse.

A firewall can allow, drop, or alert based on its supported inspection features and configured policy. Routing provides the path; the firewall evaluates the traffic.

## Traffic types

| Traffic | Example | Design consideration |
| --- | --- | --- |
| East-west | Application VPC to database VPC | Inspect private cross-VPC traffic without a direct bypass |
| Outbound / egress | Private workload to internet | Coordinate firewall, NAT, and internet routing |
| Inbound / ingress | Internet client to hosted application | Use an appropriate ingress-specific architecture; it is not simply the outbound path reversed |
| Hybrid | On-premises application to AWS | Include VPN/DX routing and return paths in the design |

Not all same-VPC traffic automatically traverses TGW or the central firewall. Define the exact traffic scope first.

## Why symmetric routing matters

Stateful firewalls track a connection. If the request traverses one inspection path and the response bypasses it or reaches a different stateful appliance, the session may fail.

In traditional TGW inspection-VPC designs, appliance mode helps maintain flow symmetry across Availability Zones. It does not replace correct VPC routes, TGW associations, propagation, or firewall policy. Native TGW-attached Network Firewall manages appliance mode automatically.

## Centralized versus distributed inspection

| Approach | Benefits | Tradeoffs |
| --- | --- | --- |
| Centralized | Shared policy management and inspection operations across accounts | Routing complexity, shared failure/change scope, processing and connectivity costs |
| Distributed | Inspection close to each workload and independent workload boundaries | More deployments and policy coordination across environments |

Choose based on traffic patterns, isolation, availability, ownership, and total cost—not simply the number of VPCs.

## What inspection does not replace

- Security groups and least-privilege application access.
- IAM and account-level governance.
- Application authentication, authorization, and patching.
- Appropriate application-layer protections.
- TLS-aware design: encrypted payload visibility depends on supported, explicitly configured decryption and its trust requirements.

## Classroom discussion

A company has Development, Production, and Shared Services VPCs. Production needs a shared directory service, but Development must not directly access Production.

Discuss:

1. Which connections should exist before considering firewall rules?
2. Which routes force the permitted connections through inspection?
3. Could a direct route create a bypass?
4. How would you prove both directions were inspected?
5. What happens if a firewall endpoint or an AZ becomes unavailable?

**Learner takeaway:** Be able to draw one forward and return traffic path, identify the enforcement point, and explain one availability and one cost tradeoff. No paid deployment or firewall provisioning is assigned.

## AWS documentation and architecture references

- [Centralized network security for VPC-to-VPC and on-premises traffic](https://docs.aws.amazon.com/whitepapers/latest/building-scalable-secure-multi-vpc-network-infrastructure/centralized-network-security-for-vpc-to-vpc-and-on-premises-to-vpc-traffic.html)
- [GWLB with Transit Gateway for centralized security](https://docs.aws.amazon.com/whitepapers/latest/building-scalable-secure-multi-vpc-network-infrastructure/using-gwlb-with-tg-for-cns.html)
- [How Transit Gateway works, including appliance mode](https://docs.aws.amazon.com/vpc/latest/tgw/how-transit-gateways-work.html)
- [AWS Network Firewall deployment models](https://aws.amazon.com/blogs/networking-and-content-delivery/deployment-models-for-aws-network-firewall-transit-gateway-attachment-and-multiple-vpc-endpoints/)
- [Network Firewall pricing](https://aws.amazon.com/network-firewall/pricing/)

[Back to Week 2](../../README.md) · [TGW/RAM instructor demo](../labs/README.md) · [VPC hands-on assignment](../assignments/README.md)
