# setup-claude-playbook.ps1
# Simple script to extract and setup Claude Code Playbook
# Run this in your repository root: G:\My Drive\acp-simulation

param(
    [string]$ZipPath = ".\claude-playbook-complete.zip"
)

$ErrorActionPreference = "Stop"

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "Claude Code Playbook Setup" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Check if zip exists
if (-not (Test-Path $ZipPath)) {
    Write-Host "ERROR: Cannot find $ZipPath" -ForegroundColor Red
    Write-Host "Please ensure claude-playbook-complete.zip is in the current directory" -ForegroundColor Yellow
    exit 1
}

Write-Host "✓ Found: $ZipPath" -ForegroundColor Green

# Extract to current directory
Write-Host "`nExtracting files..." -ForegroundColor Cyan
try {
    Expand-Archive -Path $ZipPath -DestinationPath "." -Force
    Write-Host "✓ Files extracted successfully" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Failed to extract: $_" -ForegroundColor Red
    exit 1
}

# Verify .claude directory exists
if (Test-Path ".\.claude") {
    Write-Host "✓ .claude directory created" -ForegroundColor Green
    
    # Count files
    $fileCount = (Get-ChildItem -Path ".\.claude" -Recurse -File).Count
    Write-Host "✓ $fileCount files in .claude/" -ForegroundColor Green
} else {
    Write-Host "ERROR: .claude directory not found after extraction" -ForegroundColor Red
    exit 1
}

# Verify key files
$keyFiles = @(
    ".\.claude\skills\README.md",
    ".\.claude\skills\python-scientific\SKILL.md",
    ".\.claude\skills\refactoring\SKILL.md",
    ".\README.md",
    ".\CHANGELOG.md",
    ".\QUICK_REFERENCE.md"
)

Write-Host "`nVerifying key files..." -ForegroundColor Cyan
$allGood = $true
foreach ($file in $keyFiles) {
    if (Test-Path $file) {
        Write-Host "✓ $file" -ForegroundColor Green
    } else {
        Write-Host "✗ $file (missing)" -ForegroundColor Red
        $allGood = $false
    }
}

if (-not $allGood) {
    Write-Host "`nERROR: Some files are missing. Check the extraction." -ForegroundColor Red
    exit 1
}

Write-Host "`n============================================" -ForegroundColor Green
Write-Host "SUCCESS! Claude Code Playbook is ready" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green

Write-Host "`nNext steps:" -ForegroundColor Cyan
Write-Host "1. Review the files:"
Write-Host "   - .claude\skills\README.md (skills overview)"
Write-Host "   - QUICK_REFERENCE.md (daily reference)"
Write-Host ""
Write-Host "2. Add to git:"
Write-Host "   git add .claude/"
Write-Host "   git add README.md CHANGELOG.md QUICK_REFERENCE.md"
Write-Host "   git status"
Write-Host ""
Write-Host "3. Commit:"
Write-Host '   git commit -m "feat: Integrate Claude Code Playbook v4.0.0"'
Write-Host ""
Write-Host "4. Push:"
Write-Host "   git push origin feat/acts-integration"
Write-Host ""
Write-Host "5. Start using:"
Write-Host "   view .claude/skills/README.md"
Write-Host ""
