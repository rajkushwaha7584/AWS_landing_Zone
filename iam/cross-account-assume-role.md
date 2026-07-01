# Cross Account Assume Role

## Source Account

network-account  
Account ID: 602506755932

## Target Account

sandbox-account  
Account ID: 961828155967

## Role Created

Role name: SandboxEC2ReadOnlyRole  
Policy attached: AmazonEC2ReadOnlyAccess  
Role ARN: arn:aws:iam::961828155967:role/SandboxEC2ReadOnlyRole

## Result

Successfully switched from network-account to sandbox-account using SandboxEC2ReadOnlyRole.

EC2 read access worked.  
EC2 launch failed because the role does not allow ec2:CreateSecurityGroup or ec2:RunInstances.

## Learning

Cross-account AssumeRole allows one AWS account to access another account using temporary permissions.

This is used in industry for:

- CI/CD deployment
- Platform admin access
- Security audit access
- Break-glass emergency access
