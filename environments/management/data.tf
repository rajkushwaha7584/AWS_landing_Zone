# Reads the current AWS Organization so we can reference the root ID dynamically.
# This avoids hardcoding root IDs like r-xxxx in OU resources.
data "aws_organizations_organization" "current" {}
