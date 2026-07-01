# Import Notes

The current Landing Zone was created manually using AWS Control Tower console.

Before Terraform can manage existing resources, import is required.

## Existing OUs

| OU | ID |
|---|---|
| Security | ou-ekgw-gg6vzoga |
| DEV | ou-ekgw-joc90n93 |
| Sandbox | ou-ekgw-p32c19gr |
| Infrastructure | ou-ekgw-7s2hlda6 |

## Important

Do not create duplicate OUs using Terraform.

Recommended approach:

1. Write Terraform resource blocks.
2. Import existing OUs into Terraform state.
3. Run terraform plan.
4. Only apply after reviewing plan.

Example import command pattern:

terraform import aws_organizations_organizational_unit.infrastructure ou-ekgw-7s2hlda6
