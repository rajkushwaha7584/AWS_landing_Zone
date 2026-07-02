param(
  [string[]]$Environments = @(
    "environments/management",
    "environments/sandbox"
  )
)

$ErrorActionPreference = "Stop"

Write-Host "Checking Terraform formatting..."
terraform fmt -recursive -check

foreach ($Environment in $Environments) {
  Write-Host "Initializing Terraform in $Environment..."
  terraform "-chdir=$Environment" init -backend=false

  Write-Host "Validating Terraform in $Environment..."
  terraform "-chdir=$Environment" validate
}

Write-Host "Terraform checks completed successfully."
