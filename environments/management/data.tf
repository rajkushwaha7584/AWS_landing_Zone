# Purpose: Read shared AWS Organizations metadata.
# Use: Provides the organization root ID to other files like ous.tf.
# Why: Avoids hardcoding root IDs such as r-xxxx.
# Where: Used by the management environment only.
#
# Reads the current AWS Organization so we can reference the root ID dynamically.
# This avoids hardcoding root IDs like r-xxxx in OU resources.
data "aws_organizations_organization" "current" {}
