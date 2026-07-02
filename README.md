# AWS Landing Zone IaC

This repository documents and automates an AWS Landing Zone using AWS Control Tower, AWS Organizations, IAM Identity Center, SCPs, CloudTrail, AWS Config, cross-account IAM roles, networking foundation, and AFT-style account vending.

# test

## Current Lab Accounts

| Account Name             | Account ID   | OU             | Purpose                          |
| ------------------------ | ------------ | -------------- | -------------------------------- |
| abhaysahucse             | 039612843833 | Root           | Management account               |
| Aggregator account       | 889947797924 | Security       | AWS Config Aggregator            |
| CloudTrail administrator | 238480774313 | Security       | Central CloudTrail / Log Archive |
| dev-sandbox              | 855012563791 | DEV            | Dev workload                     |
| sandbox-account          | 961828155967 | Sandbox        | SCP and testing                  |
| network-account          | 602506755932 | Infrastructure | Central networking               |

## Current OU Design

Root
|-- Security
|-- DEV
|-- Sandbox
|-- Infrastructure
`-- Management account

## Completed Practicals

- AWS Control Tower landing zone structure
- OU design
- Account Factory account creation
- SCP deny outside Mumbai test
- Control Tower controls catalog review
- CloudTrail organization trail review
- CloudTrail Event History validation
- AWS Config Aggregator validation
- Infrastructure OU creation
- Network account creation
- Cross-account AssumeRole test

## Pending Industry Topics

- AFT / Terraform account vending
- AWS Config rules and conformance packs
- GuardDuty and Security Hub
- Centralized networking with Transit Gateway
- Cost governance
- Break-glass access
- Multi-account CI/CD
