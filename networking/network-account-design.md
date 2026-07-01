# Network Account Design

## Purpose

The network-account is used for centralized AWS networking.

## Future Components

- Transit Gateway
- TGW route tables
- AWS RAM sharing
- Dev/Sandbox/Prod VPC attachments
- Route 53 Resolver
- Centralized NAT Gateway
- AWS Network Firewall
- VPC endpoints
- VPC Flow Logs
- TGW Flow Logs

## CIDR Plan

| Account | VPC | CIDR |
|---|---|---|
| network-account | inspection-vpc | 10.0.0.0/16 |
| dev-sandbox | dev-vpc | 10.10.0.0/16 |
| sandbox-account | sandbox-vpc | 10.20.0.0/16 |
| future-prod | prod-vpc | 10.30.0.0/16 |

## Rule

Dev should not directly talk to Prod.

All internet egress should pass through the Network account inspection layer in production.
