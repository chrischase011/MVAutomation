Using module ".\Automation.psm1"

Set-ExecutionPolicy Bypass
<# Program: MVAutomation, Author: Chase, Description: Automate Renaming Files #>

Write-Host "Welcome to MVAutomation by Chase `n`n"

$a = [Automation]::new()

$a.Main()

# Prevents instant exit
Pause