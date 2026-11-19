# CloudFormation vs Terraform — EC2 SSM IAM Role

This folder contains [`ssm-ec2-role.yaml`](ssm-ec2-role.yaml), a CloudFormation template that creates the **same IAM role, AWS-managed policy attachment, and instance profile** as [`../terraform/IAM.tf`](../terraform/IAM.tf).

| Concept | CloudFormation | Terraform |
| --- | --- | --- |
| EC2 trust | `AssumeRolePolicyDocument` | `assume_role_policy` |
| SSM permission | `ManagedPolicyArns` | `aws_iam_role_policy_attachment` |
| EC2 attachment mechanism | `AWS::IAM::InstanceProfile` | `aws_iam_instance_profile` |

**Both use** the AWS-managed `AmazonSSMManagedInstanceCore` policy and the same EC2 service trust principal (`ec2.amazonaws.com`). They are alternatives, **not two resources to deploy together**: both use the same fixed IAM role and instance-profile names.

## CloudFormation demo (separate from the Terraform lab)

In a disposable AWS account, with the Terraform-created role **not deployed**:

```bash
aws cloudformation deploy \
  --template-file ssm-ec2-role.yaml \
  --stack-name week3-ec2-ssm-demo \
  --capabilities CAPABILITY_NAMED_IAM

aws cloudformation describe-stacks --stack-name week3-ec2-ssm-demo
```

Inspect the role, attached managed policy, and instance profile in the AWS IAM console. Remove the demonstration stack afterward:

```bash
aws cloudformation delete-stack --stack-name week3-ec2-ssm-demo
aws cloudformation wait stack-delete-complete --stack-name week3-ec2-ssm-demo
```

**Important:** Do not deploy CloudFormation and Terraform versions simultaneously in the same account. IAM roles are account-wide, and the fixed names will conflict. CloudFormation does not attach the profile to an EC2 instance; the Terraform example does.

**SSM connectivity:** An instance profile is only one requirement. The EC2 instance needs a running SSM Agent and outbound HTTPS connectivity to the appropriate Systems Manager endpoints. The Week 3 Ubuntu image may require installing the agent; verify its status. These examples do not guarantee a managed-node connection.

## Student discussion
Why does EC2 need a trust policy? What permissions does `AmazonSSMManagedInstanceCore` provide? What is the difference between a role and an instance profile?
