# Transit Gateway and Multi-Account Connectivity

## Learning goals

Explain centralized connectivity, RAM sharing, attachments, and routing ownership.

## How it works

A Transit Gateway connects VPCs and other supported networks through attachments. AWS RAM lets approved accounts use a centrally owned TGW for their VPC attachments.

Sharing grants access to the resource; attachments and routes still need configuration. The TGW owner manages TGW route tables, associations, and propagation. Workload owners manage their VPC routes and access controls.

| Concept | Meaning |
| --- | --- |
| RAM share | Makes the TGW available to approved participants |
| Attachment | Connects a VPC to the TGW |
| Association | Selects the TGW route table for traffic arriving from an attachment |
| Propagation | Adds attachment routes into selected TGW route tables |
| VPC route | Sends destination traffic from a subnet toward TGW |

Both forward and return paths must work. Connected VPCs are not automatically segmented or inspected; routing and security policy determine reachability.

## Instructor showcase

See [Multi-Account TGW with AWS RAM](../labs/README.md) for the account topology, sharing walkthrough, attachment acceptance, route examples, and private-IP validation.

Students observe and explain the path; a paid TGW deployment is not required.

## Discussion

When would a hub simplify operations compared with many peering connections? How would separate TGW route tables help isolate Development and Production?

## References

- [Work with and share Transit Gateways](https://docs.aws.amazon.com/vpc/latest/tgw/working-with-transit-gateways.html)
- [TGW route tables](https://docs.aws.amazon.com/vpc/latest/tgw/tgw-route-tables.html)

[Back to Week 2](../../README.md)
