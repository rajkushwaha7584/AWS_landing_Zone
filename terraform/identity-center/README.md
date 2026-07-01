# IAM Identity Center Terraform Design

In a small setup, users can be created in IAM Identity Center internal directory.

In enterprise setup, users usually come from:

- Microsoft Entra ID
- Okta
- Google Workspace
- Active Directory

Industry best practice:

User -> Group -> Permission Set -> AWS Account

Avoid direct user-to-account assignment where possible.

Example groups:

- AWS-Dev-Admins
- AWS-Prod-ReadOnly
- AWS-Network-Admins
- AWS-Security-Auditors

Terraform commonly manages:

- Permission sets
- Account assignments
- Groups if internal directory is used

Passwords and secrets should never be stored in Terraform code.
