$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$outPath = Join-Path $PSScriptRoot "aws-landing-zone-foundation.pptx"

$ppLayoutBlank = 12
$msoTextOrientationHorizontal = 1
$msoShapeRectangle = 1
$msoShapeRoundedRectangle = 5
$msoShapeRightArrow = 33
$msoConnectorStraight = 1
$msoTrue = -1

function Set-Text {
  param(
    $Shape,
    [string]$Text,
    [int]$Size = 20,
    [int]$Color = 0x222222,
    [bool]$Bold = $false
  )

  $Shape.TextFrame.TextRange.Text = $Text
  $Shape.TextFrame.TextRange.Font.Size = $Size
  $Shape.TextFrame.TextRange.Font.Color.RGB = $Color
  $Shape.TextFrame.TextRange.Font.Bold = if ($Bold) { $msoTrue } else { 0 }
}

function Add-Title {
  param($Slide, [string]$Title, [string]$Subtitle = "")

  $box = $Slide.Shapes.AddTextbox($msoTextOrientationHorizontal, 40, 25, 860, 45)
  Set-Text $box $Title 30 0x12355B $true

  if ($Subtitle -ne "") {
    $sub = $Slide.Shapes.AddTextbox($msoTextOrientationHorizontal, 42, 70, 850, 30)
    Set-Text $sub $Subtitle 14 0x666666 $false
  }
}

function Add-Bullets {
  param($Slide, [string[]]$Items, [int]$Left = 65, [int]$Top = 125, [int]$Width = 820, [int]$Height = 340)

  $text = ($Items | ForEach-Object { "• $_" }) -join "`r`n"
  $box = $Slide.Shapes.AddTextbox($msoTextOrientationHorizontal, $Left, $Top, $Width, $Height)
  Set-Text $box $text 19 0x222222 $false
  $box.TextFrame.TextRange.ParagraphFormat.SpaceAfter = 8
}

function Add-Placeholder {
  param($Slide, [string]$Label, [int]$Left = 540, [int]$Top = 130, [int]$Width = 360, [int]$Height = 260)

  $shape = $Slide.Shapes.AddShape($msoShapeRoundedRectangle, $Left, $Top, $Width, $Height)
  $shape.Fill.ForeColor.RGB = 0xF3F6FA
  $shape.Line.ForeColor.RGB = 0x9AA7B2
  Set-Text $shape "Screenshot placeholder`r`n$Label" 16 0x4A5568 $true
}

function Add-SectionTag {
  param($Slide, [string]$Text)

  $tag = $Slide.Shapes.AddShape($msoShapeRoundedRectangle, 40, 500, 240, 32)
  $tag.Fill.ForeColor.RGB = 0xE8F1FF
  $tag.Line.Visible = 0
  Set-Text $tag $Text 13 0x1D4ED8 $true
}

function Add-Slide {
  param($Presentation)

  return $Presentation.Slides.Add($Presentation.Slides.Count + 1, $ppLayoutBlank)
}

$ppt = New-Object -ComObject PowerPoint.Application
$ppt.Visible = $msoTrue
$presentation = $ppt.Presentations.Add()
$presentation.PageSetup.SlideWidth = 960
$presentation.PageSetup.SlideHeight = 540

# Slide 1
$slide = Add-Slide $presentation
Add-Title $slide "AWS Landing Zone Foundation" "Terraform, AWS Organizations, SCP guardrails, cross-account IAM, and CI validation"
Add-Bullets $slide @(
  "Working lab/demo landing zone foundation",
  "Multi-account AWS structure with management and sandbox environments",
  "CI validation through GitHub Actions",
  "Production hardening documented as next phase"
) 70 145 520 260
Add-Placeholder $slide "01-access-portal.png" 620 130 280 250
Add-SectionTag $slide "Opening"

# Slide 2
$slide = Add-Slide $presentation
Add-Title $slide "Project Objective"
Add-Bullets $slide @(
  "Create a repeatable AWS Landing Zone foundation",
  "Use Terraform for organization and account-level resources",
  "Apply governance with Service Control Policies",
  "Validate code automatically with CI pipeline",
  "Keep risky apply operations manual and controlled"
)
Add-SectionTag $slide "Goal"

# Slide 3
$slide = Add-Slide $presentation
Add-Title $slide "Account Structure"
Add-Bullets $slide @(
  "Management account: 039612843833",
  "Sandbox account: 961828155967",
  "Network account: 602506755932",
  "Security accounts for Config aggregation and CloudTrail/logging",
  "Access is centralized through AWS Access Portal"
) 55 130 430 310
Add-Placeholder $slide "01-access-portal.png" 540 120 360 300
Add-SectionTag $slide "Accounts"

# Slide 4
$slide = Add-Slide $presentation
Add-Title $slide "Control Tower And OU Structure"
Add-Bullets $slide @(
  "OUs group accounts by governance boundary",
  "Control Tower provides baseline governance",
  "Sandbox OU receives test and security baseline SCPs",
  "New OUs/accounts should be registered or enrolled for full governance"
) 55 130 430 300
Add-Placeholder $slide "02-control-tower-organization.png" 540 120 360 300
Add-SectionTag $slide "Governance"

# Slide 5: Architecture flow
$slide = Add-Slide $presentation
Add-Title $slide "Landing Zone Flow"
$labels = @(
  @("AWS Access Portal", 70, 125),
  @("Management Account", 325, 80),
  @("AWS Organizations", 585, 80),
  @("SCP Guardrails", 585, 190),
  @("Sandbox Account", 325, 260),
  @("Network Account", 70, 260),
  @("AssumeRole", 325, 380)
)
foreach ($item in $labels) {
  $s = $slide.Shapes.AddShape($msoShapeRoundedRectangle, $item[1], $item[2], 190, 58)
  $s.Fill.ForeColor.RGB = 0xEAF2FF
  $s.Line.ForeColor.RGB = 0x3B82F6
  Set-Text $s $item[0] 15 0x12355B $true
}
$connections = @(
  @(260,154,325,109), @(515,109,585,109), @(680,138,680,190),
  @(585,219,515,289), @(260,289,325,409), @(165,318,325,409)
)
foreach ($c in $connections) {
  $line = $slide.Shapes.AddConnector($msoConnectorStraight, $c[0], $c[1], $c[2], $c[3])
  $line.Line.ForeColor.RGB = 0x64748B
  $line.Line.Weight = 2
}
Add-SectionTag $slide "Architecture"

# Slide 6
$slide = Add-Slide $presentation
Add-Title $slide "Terraform Repository Layout"
Add-Bullets $slide @(
  "environments/management: OUs, SCPs, account records",
  "environments/sandbox: sandbox account IAM role",
  "modules: reusable Terraform building blocks",
  "policies/scp: Service Control Policy JSON documents",
  "scripts: local CI and safe plan helpers"
) 55 125 430 310
Add-Placeholder $slide "10-project-structure.png" 540 120 360 300
Add-SectionTag $slide "Code"

# Slide 7
$slide = Add-Slide $presentation
Add-Title $slide "Management Environment"
Add-Bullets $slide @(
  "Runs against the AWS Organizations management account",
  "Uses allowed_account_ids to block wrong-profile execution",
  "Creates and attaches SCP policies",
  "Protects lab-created accounts with prevent_destroy",
  "Outputs important IDs for verification"
)
Add-SectionTag $slide "Management"

# Slide 8
$slide = Add-Slide $presentation
Add-Title $slide "SCP Guardrails"
Add-Bullets $slide @(
  "Deny EC2 actions outside ap-south-1 for sandbox testing",
  "Sandbox baseline protects CloudTrail, Config, and security services",
  "SCPs do not grant permissions",
  "SCPs define maximum permissions for accounts and OUs"
) 55 130 430 310
Add-Placeholder $slide "03-organizations-scp.png / 04-scp-targets.png" 540 120 360 300
Add-SectionTag $slide "Guardrails"

# Slide 9
$slide = Add-Slide $presentation
Add-Title $slide "Sandbox Environment"
Add-Bullets $slide @(
  "Runs inside sandbox account 961828155967",
  "Creates SandboxEC2ReadOnlyRole",
  "Network account can assume this role",
  "Role has AmazonEC2ReadOnlyAccess",
  "Useful for cross-account access validation"
) 55 130 430 310
Add-Placeholder $slide "05-sandbox-role.png" 540 120 360 300
Add-SectionTag $slide "Sandbox"

# Slide 10
$slide = Add-Slide $presentation
Add-Title $slide "Cross-Account IAM Flow"
Add-Bullets $slide @(
  "Network account requests STS AssumeRole",
  "Sandbox role trust policy allows network account",
  "STS returns temporary credentials",
  "Temporary credentials provide EC2 read-only access",
  "No long-lived IAM user is required in the sandbox account"
) 55 130 430 310
Add-Placeholder $slide "06-role-trust-policy.png" 540 120 360 300
Add-SectionTag $slide "IAM"

# Slide 11
$slide = Add-Slide $presentation
Add-Title $slide "CI/CD Validation"
Add-Bullets $slide @(
  "GitHub Actions runs Terraform CI automatically",
  "Checks terraform fmt, init, and validate",
  "Runs for management and sandbox environments",
  "Apply remains manual for safety",
  "Local script mirrors the same checks"
) 55 130 430 310
Add-Placeholder $slide "07-github-actions.png" 540 120 360 300
Add-SectionTag $slide "CI/CD"

# Slide 12
$slide = Add-Slide $presentation
Add-Title $slide "Safe Operation Commands"
Add-Bullets $slide @(
  "Local CI: powershell -ExecutionPolicy Bypass -File scripts\terraform-checks.ps1",
  "Management plan: bash scripts/plan-management.sh",
  "Sandbox plan: bash scripts/plan-sandbox.sh",
  "Scripts verify the active AWS account",
  "Scripts do not store secrets and do not apply changes"
)
Add-SectionTag $slide "Operations"

# Slide 13
$slide = Add-Slide $presentation
Add-Title $slide "Current Completion Status"
Add-Bullets $slide @(
  "AWS Landing Zone lab/demo foundation is complete",
  "Management and sandbox Terraform environments validate successfully",
  "SCP guardrails and sandbox IAM role are implemented",
  "GitHub Actions CI is green",
  "Documentation and presentation material are prepared"
)
Add-SectionTag $slide "Status"

# Slide 14
$slide = Add-Slide $presentation
Add-Title $slide "Remaining Production Hardening"
Add-Bullets $slide @(
  "Remote S3 backend for Terraform state",
  "AFT / Control Tower Account Factory account vending",
  "GuardDuty, Security Hub, and AWS Config automation",
  "Centralized logging and monitoring",
  "Network baseline / Transit Gateway",
  "IAM Identity Center automation and cost governance"
)
Add-SectionTag $slide "Next Phase"

# Slide 15
$slide = Add-Slide $presentation
Add-Title $slide "Closing"
Add-Bullets $slide @(
  "The project demonstrates a working AWS Landing Zone foundation",
  "Terraform provides repeatability and safety checks",
  "GitHub Actions validates code automatically",
  "AWS Access Portal centralizes multi-account access",
  "Production hardening is documented as the next phase"
) 80 150 780 260
Add-SectionTag $slide "Thank You"

$presentation.SaveAs($outPath)
$presentation.Close()
$ppt.Quit()

Write-Host "Created PowerPoint deck: $outPath"
