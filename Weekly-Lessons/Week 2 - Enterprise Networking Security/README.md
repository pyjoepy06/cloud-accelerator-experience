# Week 2 — Enterprise Networking & Security

Think like an Architect, build like an Engineer, communicate with confidence.

## Outcomes

Trace AWS traffic paths, explain public/private subnet design, compare network security controls, and understand multi-account connectivity through Transit Gateway and AWS RAM.

## Lesson topics

- [VPC Design](enterprise-networking-security/vpc-design/README.md)
- [Transit Gateway and RAM](enterprise-networking-security/transit-gateway/README.md)
- [Hybrid Connectivity](enterprise-networking-security/hybrid-connectivity/README.md)
- [Network Security and AI Investigator](enterprise-networking-security/network-security/README.md)
- [Centralized Inspection — conceptual overview](enterprise-networking-security/centralized-inspection/README.md)

## Live showcase

[Multi-account TGW and RAM instructor demo](enterprise-networking-security/labs/README.md): sharing, VPC attachments, route tables, and private connectivity validation. Includes a discussion of ownership across accounts.

The instructor also showcases a read-only Bedrock network security investigator: model intelligence, Python/Boto3 tools, and IAM permissions.

## Hands-on assignment

[Build a public/private VPC lab](enterprise-networking-security/assignments/README.md): create a VPC, two subnets, a NAT gateway, and public/private EC2 instances. Validate outbound access, document your reasoning, and remove all lab resources.

Hybrid connectivity and centralized inspection are architecture discussions, not required paid deployments.

## Learning workflow

Translate existing networking knowledge → understand the design → observe the enterprise showcase → build the small VPC lab → validate traffic → explain the evidence.

Retain a sanitized diagram and findings for your capstone. Use a training account, monitor costs, and follow the assignment cleanup instructions.
