# Guided Lab — Deploy Three Tiers with Static Terraform

Start with [the Terraform starter](../terraform/main.tf). Work in pairs; do not write variables yet.

1. **Prepare:** Install Terraform and AWS CLI, authenticate, and run `aws sts get-caller-identity`. Confirm you are in a dedicated lab account.
2. **Read:** Identify the VPC block, all three subnet blocks, all three route tables, all three associations, and all three EC2 instances. Predict which subnet is public.
3. **Initialize:** From `../terraform/`, run `terraform init`.
4. **Check:** Run `terraform fmt` and `terraform validate`.
5. **Preview:** Run `terraform plan`. Find each of the three EC2 instances in the plan.
6. **Deploy:** Run `terraform apply`; review the plan and approve with `yes`.
7. **Verify:** In AWS Console, inspect the `week3-class-vpc`, subnet CIDRs, route-table associations, web default route, security-group ingress, and three EC2 instances.
8. **Explain:** Why does the web subnet have an Internet Gateway route but the app and DB subnets do not? Why can the web security group reach port 8080 on the app security group?
9. **Destroy:** Run `terraform destroy` and verify cleanup.

## Expected result
Three running EC2 infrastructure placeholders, one in each subnet. **No working web app or database is installed.** There is no SSH ingress and no NAT; private instances are intentionally not reachable from the public internet.

## Optional instructor demo
Change one hardcoded value into an input variable **live**, then run `terraform plan` again. Do not introduce loops, modules, or pipelines in the first lab.

## Cost and safety
Resources may incur charges. Use billing alerts. Do not commit `.terraform/`, `*.tfstate`, `*.tfstate.*`, or credentials. Always destroy the lab before leaving.
