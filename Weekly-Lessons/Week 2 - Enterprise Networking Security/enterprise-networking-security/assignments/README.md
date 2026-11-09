# Assignment — Build a Public and Private VPC Lab

**Week 2: Enterprise Networking & Security**  
**Time:** Approximately 60–90 minutes  
**Method:** AWS Management Console

Think like an Architect, build like an Engineer, communicate with confidence.

## Goal

Create a VPC with public and private subnets, deploy one EC2 instance in each, and prove how the private instance accesses the internet through a NAT gateway.

## Before you start

- Use a dedicated training account and one AWS Region.
- You need permission to manage VPCs, subnets, route tables, internet gateways, NAT gateways, Elastic IPs, security groups, key pairs, and EC2 instances.
- Have a local SSH client and an EC2 key pair. Keep the private key on your computer; never upload it to an instance or GitHub.
- Set a billing alert. EC2, EBS, NAT gateway hours/data processing, and public IPv4 addresses can incur charges. Do not assume Free Tier covers this lab. Review [VPC pricing](https://aws.amazon.com/vpc/pricing/) and [EC2 pricing](https://aws.amazon.com/ec2/pricing/).
- Delete the resources when finished. Stopping EC2 does not stop NAT gateway or storage charges.

## 1. Build the network

In the VPC console, create **VPC only**, then create the following resources manually so you understand each connection. Use IPv4 only for this exercise.

| Resource | Name / configuration |
| --- | --- |
| VPC | `week2-vpc` — `10.20.0.0/16`; enable DNS resolution |
| Public subnet | `week2-public` — `10.20.1.0/24` |
| Private subnet | `week2-private` — `10.20.2.0/24` |
| Availability Zone | Put both subnets in the same AZ for this small lab |
| Internet gateway | `week2-igw` — attach it to the VPC |
| Public route table | `week2-public-rt` — explicitly associate the public subnet |
| Private route table | `week2-private-rt` — explicitly associate the private subnet |

Keep the automatic local route in both route tables. Add these default routes:

| Route table | Destination | Target |
| --- | --- | --- |
| Public | `0.0.0.0/0` | Internet gateway |
| Private | `0.0.0.0/0` | NAT gateway created in Step 2 |

A public subnet has a direct route to an internet gateway. A private subnet does not. A subnet name or public-IP setting alone does not make it public.

## 2. Create the NAT gateway

1. Create a **public, zonal NAT gateway** in `week2-public`.
2. Allocate and associate a new Elastic IP address.
3. Wait until the NAT gateway is **Available**.
4. Add the private route table's default route to this NAT gateway.
5. Confirm the public route table still points to the internet gateway.

Private instance outbound path: **private EC2 → NAT gateway → internet gateway → internet**.

This one-AZ design is for learning. It is not a highly available production architecture.

## 3. Launch two EC2 instances

Use Amazon Linux 2023, a small permitted instance type such as `t3.micro`, the same key pair, and a small default root volume. Require IMDSv2 and enable delete-on-termination for the root volume.

| Setting | Public EC2 | Private EC2 |
| --- | --- | --- |
| Name | `week2-public-ec2` | `week2-private-ec2` |
| Subnet | Public subnet | Private subnet |
| Auto-assign public IPv4 | Enable | Disable |
| Security group | `week2-public-sg` | `week2-private-sg` |
| Inbound SSH, TCP 22 | Your computer's public IPv4 **/32** only | Source: `week2-public-sg` |
| Outbound | Keep default allow-all for this lab | Keep default allow-all for this lab |

Keep the default network ACL unchanged. Do not open SSH to `0.0.0.0/0`. No inbound HTTP rule is needed.

## 4. Connect and test

Replace the uppercase placeholders below with your values. Run SSH commands on your computer. On macOS/Linux, restrict the private-key file permissions first:

```bash
chmod 400 week2-key.pem
```

### Public instance

```bash
ssh -i week2-key.pem ec2-user@PUBLIC_IP
```

Inside the instance:

```bash
curl -I --connect-timeout 10 https://aws.amazon.com
curl --connect-timeout 10 https://checkip.amazonaws.com
```

Expect an HTTP response and an outbound IPv4 address matching the public instance's public IPv4.

### Private instance

Exit back to your computer. Use the public instance as an SSH jump host without copying your private key to it:

```bash
ssh -i week2-key.pem -o 'ProxyCommand=ssh -i week2-key.pem -W %h:%p ec2-user@PUBLIC_IP' ec2-user@PRIVATE_IP
```

Inside the private instance, run the same two curl commands.

**Expected:** HTTPS works, and the outbound IPv4 address matches the NAT gateway's Elastic IP. Confirm in the EC2 console that the private instance has no public IPv4 address.

The NAT gateway enables outbound connections and their responses. It does not provide inbound SSH access; the public EC2 jump host provides your management path.

### Prove the NAT route matters

1. Keep your private-instance SSH session open.
2. Temporarily remove only `0.0.0.0/0 → NAT gateway` from the private route table.
3. Repeat the HTTPS curl test. Expect failure.
4. Restore that route and repeat. Expect success.

Your SSH session uses the VPC local route, so it should remain connected. Do not delete the local route.

## 5. Explain what you built

Answer briefly:

1. What makes your public subnet public?
2. Why can the private EC2 reach the internet without a public IP?
3. Why does the NAT gateway belong in the public subnet?
4. Why does the private EC2 allow SSH from the public security group instead of the entire internet?
5. What would you change for a production application spanning two AZs?

If a test fails, check subnet route-table associations, gateway state, public-IP assignment, security group sources, and the SSH username/key before changing rules.

## Submit

Add the following to your assignment submission:

- A simple diagram with both subnets, EC2 instances, route tables, IGW, and NAT gateway.
- Screenshots of both route tables and EC2 networking details.
- Public/private curl results, including the private instance's NAT Elastic IP result.
- Your five short answers and confirmation that cleanup is complete.

Never submit private keys, credentials, or account-sensitive screenshots.

**Success:** Both instances launch, public EC2 is reachable only from your approved SSH source, private EC2 has no public IP, private outbound HTTPS uses the NAT Elastic IP, and removing/restoring the NAT route changes the test result.

## 6. Cleanup — required

1. Terminate both EC2 instances and wait for termination.
2. Confirm their root EBS volumes were deleted; remove leftover lab volumes.
3. Delete the NAT gateway and wait until deletion completes.
4. Release its Elastic IP address; deleting the NAT gateway does not release it.
5. Delete the custom security groups after instance interfaces are removed.
6. Remove custom route-table associations, then delete the custom route tables and subnets.
7. Detach/delete the internet gateway, then delete the lab VPC.
8. Remove any key pair created solely for this lab and securely remove its local private key.
9. Check for leftover lab resources, including Elastic IPs and EBS volumes.

## AWS references

- [NAT gateways](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html)
- [Internet gateway requirements](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html)
- [Connect to EC2](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/connect.html)
