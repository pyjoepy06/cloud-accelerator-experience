# Instructor Demo — Multi-Account Transit Gateway with AWS RAM

**Week 2: Enterprise Networking & Security**  
**Format:** Instructor-led showcase; students observe, trace traffic, and discuss.  
**Student deployment:** Not required.

Think like an Architect, build like an Engineer, communicate with confidence.

## What we will showcase

The instructor will connect VPCs in multiple AWS accounts through a centrally owned AWS Transit Gateway (TGW), share the TGW using AWS Resource Access Manager (RAM), and explain the routes required for communication.

By the end, learners should be able to:

- Explain why an enterprise uses a centralized TGW across accounts.
- Describe how RAM shares access to a TGW.
- Distinguish resource-share acceptance from VPC attachment acceptance.
- Trace forward and return traffic through VPC and TGW route tables.
- Explain which configuration belongs to the TGW owner versus the VPC owner.

## Example environment

All resources are in the same AWS Region. CIDRs are examples and must not overlap.

| Account | Resource | Example CIDR |
| --- | --- | --- |
| Network / Shared Services | Owns the TGW and RAM resource share | — |
| Workload A | VPC A and a test EC2 instance | `10.10.0.0/16` |
| Workload B | VPC B and a test EC2 instance | `10.20.0.0/16` |

Traffic path: **EC2 A → VPC A route table → TGW attachment A → TGW route table → TGW attachment B → EC2 B**. Return traffic needs a valid path in the opposite direction.

Sharing a TGW does not share the workload subnets or automatically provide connectivity.

## Instructor preparation

- Use isolated training accounts and confirm access to each account.
- Prepare non-overlapping VPCs, attachment subnets, and test instances in the same Region.
- Select one attachment subnet per AZ used by the test workloads.
- Have permissions to manage the TGW and RAM share in the owner account, and attachments, routes, and test security groups in workload accounts.
- If sharing with organization/OU principals, enable RAM sharing with AWS Organizations from the management account first.
- Prepare a management connection to each test instance, such as an existing Systems Manager session; verify its IAM and network prerequisites separately.
- Allow the chosen test traffic between the specific test endpoints. Keep management access restricted.
- Capture route tables and a successful connectivity test as fallback evidence.

## Demo walkthrough

### 1. Show the account boundaries

Identify the TGW owner, each VPC owner, the Region, and each VPC CIDR. Ask students why centralized networking does not require placing all workloads in one account.

### 2. Show the Transit Gateway

In the Network / Shared Services account, open the TGW and explain:

- Its ID and ownership.
- Auto-accept shared attachments.
- Default route-table association and propagation settings.
- Why attachment availability and routing are separate checks.

For a clear walkthrough, use explicit attachment acceptance and an identified TGW route table.

### 3. Share the TGW through AWS RAM

In the owner account:

1. Open **AWS RAM → Resource shares → Create resource share**.
2. Select the Transit Gateway resource.
3. Choose the intended workload account principals, or the approved organization/OU.
4. Create the share and inspect its status.

In each participant account, show the shared TGW. Accept a RAM invitation if one is required. Organization sharing with RAM organization integration enabled does not require invitations between accounts in that organization.

**Key distinction:** Accepting a RAM share grants access to use the shared resource. It does not accept a VPC attachment or configure routes.

### 4. Create the VPC attachments

In each workload account:

1. Create a TGW VPC attachment to the shared TGW.
2. Select that account's VPC and the appropriate attachment subnets.
3. In the TGW owner account, accept pending attachments if auto-accept is disabled.
4. Wait until both attachments are **Available**.

Participants manage their VPC attachments and VPC routes. The TGW owner controls TGW route tables, associations, and propagations.

### 5. Configure and explain routing

For this simple demo, associate both attachments with one TGW route table and enable propagation from both VPC attachments into it.

| Route table | Destination | Target |
| --- | --- | --- |
| VPC A test subnet | `10.20.0.0/16` | Shared TGW |
| VPC B test subnet | `10.10.0.0/16` | Shared TGW |
| TGW demo route table | `10.10.0.0/16` | VPC A attachment |
| TGW demo route table | `10.20.0.0/16` | VPC B attachment |

Retain the local VPC routes. Check the effective route table associated with each test subnet.

- **Association:** Selects the TGW route table used for traffic arriving from an attachment.
- **Propagation:** Adds an attachment's routes into selected TGW route tables.
- A shared route table permits this demo's connectivity; separate route tables can support segmentation.

### 6. Validate connectivity

1. Confirm both attachments are Available.
2. Inspect the TGW associations, propagated routes, and VPC routes.
3. Confirm security groups and NACLs permit the selected test and return traffic.
4. From EC2 A, test EC2 B's **private IP**, then test the reverse direction.
5. For a simple ICMP demonstration, temporarily allow ICMP only between the two test private IPs:
   `ping -c 4 DESTINATION_PRIVATE_IP`.
6. Explain that a failed ping alone does not prove a routing failure; the instance OS and security controls must also permit ICMP.

No NAT gateway or public IP is required for the private VPC-to-VPC data path. Test-instance management connectivity is a separate requirement.

## Discussion questions

1. Why is RAM sharing alone insufficient for connectivity?
2. Which account accepts a RAM invitation, and which accepts a pending VPC attachment?
3. What happens if only the forward route exists?
4. How do association and propagation differ?
5. How would you prevent Development from communicating directly with Production?

## Cost and cleanup

TGW attachments, data processing, test EC2 instances, and any supporting management networking may incur charges. Review [Transit Gateway pricing](https://aws.amazon.com/transit-gateway/pricing/) before deploying.

For temporary lab resources:

1. Remove temporary test security rules and VPC routes to the TGW.
2. Delete both VPC attachments and wait for deletion.
3. Remove the RAM share, then delete temporary TGW route tables and the TGW.
4. Terminate temporary EC2 instances and remove leftover volumes and supporting resources.
5. Delete lab-only VPCs if no longer needed and check each account for leftover resources.

Do not remove shared enterprise resources during a demonstration.

## Fallback and learner takeaway

If live provisioning or connectivity is delayed, use sanitized screenshots of the RAM share, attachments, route tables, and successful private-IP tests. Clearly label captured results.

Students should leave with a simple account/VPC diagram and be able to explain: **who owns the TGW, who can attach, where routes are configured, and how connectivity is verified.**

For the separate hands-on public/private subnet assignment, see [Assignments](../assignments/README.md).

## AWS references

- [Work with and share Transit Gateways](https://docs.aws.amazon.com/vpc/latest/tgw/working-with-transit-gateways.html)
- [Transit Gateway routing](https://docs.aws.amazon.com/vpc/latest/tgw/tgw-route-tables.html)
- [Enable RAM sharing with AWS Organizations](https://docs.aws.amazon.com/ram/latest/userguide/getting-started-sharing.html)
