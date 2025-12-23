# commit-playbook.ps1
# Automated commit script for Claude Code Playbook integration
# Version: 1.0
# Date: 2024-12-18

<#
.SYNOPSIS
    Commits Claude Code Playbook integration to acp-simulation repository

.DESCRIPTION
    This script automates the process of:
    1. Verifying repository location
    2. Copying improved files
    3. Staging changes
    4. Creating commit with comprehensive message
    5. Pushing to GitHub

.PARAMETER RepoPath
    Path to the acp-simulation repository (default: G:\My Drive\acp-simulation)

.PARAMETER SourcePath
    Path to the improved claude files (default: current directory)

.PARAMETER Branch
    Branch to commit to (default: current branch)

.PARAMETER DryRun
    If specified, shows what would be done without making changes

.EXAMPLE
    .\commit-playbook.ps1
    
.EXAMPLE
    .\commit-playbook.ps1 -RepoPath "C:\projects\acp-simulation" -Branch "feat/claude-playbook"
    
.EXAMPLE
    .\commit-playbook.ps1 -DryRun
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string]$RepoPath = "G:\My Drive\acp-simulation",
    
    [Parameter(Mandatory=$false)]
    [string]$SourcePath = ".",
    
    [Parameter(Mandatory=$false)]
    [string]$Branch = "",
    
    [Parameter(Mandatory=$false)]
    [switch]$DryRun
)

# Set error action preference
$ErrorActionPreference = "Stop"

# Color functions
function Write-Success { Write-Host $args -ForegroundColor Green }
function Write-Info { Write-Host $args -ForegroundColor Cyan }
function Write-Warning { Write-Host $args -ForegroundColor Yellow }
function Write-Error { Write-Host $args -ForegroundColor Red }

# Header
Write-Info "=========================================="
Write-Info "Claude Code Playbook Integration Script"
Write-Info "=========================================="
Write-Info ""

# Step 1: Verify repository exists
Write-Info "[1/8] Verifying repository location..."
if (-not (Test-Path $RepoPath)) {
    Write-Error "ERROR: Repository not found at: $RepoPath"
    exit 1
}

if (-not (Test-Path (Join-Path $RepoPath ".git"))) {
    Write-Error "ERROR: Not a git repository: $RepoPath"
    exit 1
}

Write-Success "✓ Repository found: $RepoPath"

# Step 2: Verify source files exist
Write-Info "[2/8] Verifying source files..."
$requiredFiles = @(
    ".claude",
    "README.md",
    "CONTEXT.md",
    "CHANGELOG.md",
    "QUICK_REFERENCE.md"
)

foreach ($file in $requiredFiles) {
    $fullPath = Join-Path $SourcePath $file
    if (-not (Test-Path $fullPath)) {
        Write-Error "ERROR: Required file/directory not found: $file"
        exit 1
    }
}

Write-Success "✓ All source files present"

# Step 3: Check git status
Write-Info "[3/8] Checking git status..."
Push-Location $RepoPath

$gitStatus = git status --porcelain
if ($gitStatus -and -not $DryRun) {
    Write-Warning "WARNING: Repository has uncommitted changes:"
    Write-Host $gitStatus
    $response = Read-Host "Continue anyway? (y/n)"
    if ($response -ne 'y') {
        Write-Info "Aborted by user"
        Pop-Location
        exit 0
    }
}

# Get current branch
$currentBranch = git branch --show-current
if ([string]::IsNullOrEmpty($Branch)) {
    $Branch = $currentBranch
}
Write-Success "✓ Current branch: $currentBranch"
Write-Success "✓ Will commit to: $Branch"

# Step 4: Copy files
Write-Info "[4/8] Copying files to repository..."

if ($DryRun) {
    Write-Info "[DRY RUN] Would copy:"
    Write-Info "  - .claude/ directory"
    Write-Info "  - README.md"
    Write-Info "  - CONTEXT.md"
    Write-Info "  - CHANGELOG.md"
    Write-Info "  - QUICK_REFERENCE.md"
} else {
    try {
        # Copy .claude directory
        $claudeSource = Join-Path $SourcePath ".claude"
        $claudeDest = Join-Path $RepoPath ".claude"
        
        if (Test-Path $claudeDest) {
            Write-Warning "Backing up existing .claude directory..."
            $backupPath = "$claudeDest.backup.$(Get-Date -Format 'yyyyMMdd-HHmmss')"
            Move-Item $claudeDest $backupPath
            Write-Success "✓ Backed up to: $backupPath"
        }
        
        Copy-Item -Path $claudeSource -Destination $claudeDest -Recurse -Force
        Write-Success "✓ Copied .claude/ directory"
        
        # Copy root files
        $rootFiles = @("README.md", "CONTEXT.md", "CHANGELOG.md", "QUICK_REFERENCE.md")
        foreach ($file in $rootFiles) {
            $source = Join-Path $SourcePath $file
            $dest = Join-Path $RepoPath $file
            
            if (Test-Path $dest) {
                $backupPath = "$dest.backup.$(Get-Date -Format 'yyyyMMdd-HHmmss')"
                Copy-Item $dest $backupPath
            }
            
            Copy-Item -Path $source -Destination $dest -Force
            Write-Success "✓ Copied $file"
        }
        
        Write-Success "✓ All files copied successfully"
    }
    catch {
        Write-Error "ERROR copying files: $_"
        Pop-Location
        exit 1
    }
}

# Step 5: Verify file structure
Write-Info "[5/8] Verifying file structure..."

if ($DryRun) {
    Write-Info "[DRY RUN] Would verify file structure"
} else {
    $expectedDirs = @(
        ".claude",
        ".claude\skills",
        ".claude\skills\python-scientific",
        ".claude\skills\refactoring",
        ".claude\skills\refactoring\workflows"
    )
    
    foreach ($dir in $expectedDirs) {
        $fullPath = Join-Path $RepoPath $dir
        if (-not (Test-Path $fullPath)) {
            Write-Error "ERROR: Expected directory not found: $dir"
            Pop-Location
            exit 1
        }
    }
    
    # Count files in .claude
    $claudeFiles = Get-ChildItem -Path (Join-Path $RepoPath ".claude") -Recurse -File
    Write-Success "✓ Structure verified: $($claudeFiles.Count) files in .claude/"
}

# Step 6: Stage files
Write-Info "[6/8] Staging files..."

if ($DryRun) {
    Write-Info "[DRY RUN] Would stage:"
    Write-Info "  - git add .claude/"
    Write-Info "  - git add README.md CONTEXT.md CHANGELOG.md QUICK_REFERENCE.md"
} else {
    try {
        git add .claude/
        git add README.md CONTEXT.md CHANGELOG.md QUICK_REFERENCE.md
        
        $stagedFiles = git diff --cached --name-only
        $stagedCount = ($stagedFiles | Measure-Object).Count
        
        Write-Success "✓ Staged $stagedCount files"
        Write-Info "Staged files:"
        $stagedFiles | ForEach-Object { Write-Info "  - $_" }
    }
    catch {
        Write-Error "ERROR staging files: $_"
        Pop-Location
        exit 1
    }
}

# Step 7: Create commit
Write-Info "[7/8] Creating commit..."

$commitMessage = @"
feat: Integrate Claude Code Playbook v4.0.0 for AI-assisted development

Add comprehensive AI-assisted development system with token-efficient
workflows, scientific computing patterns, and refactoring guidance.

ADDED:
- .claude/ directory with complete playbook structure
- Python Scientific Computing skill for NumPy/SciPy patterns
- Refactoring skill with 6 specialized workflows
- Skills navigation system with multiple entry points
- Token budget tracking and session management protocols
- Quick reference card for daily development
- Comprehensive documentation and improvement summaries

FEATURES:
- 67% reduction in conversation turns (playbook standard)
- Predictable token costs per operation
- Systematic validation gates for code quality
- ACP-specific patterns for NetworkEnvironment optimization
- Reproducibility standards with explicit seed management
- Type safety with numpy.typing
- Performance profiling guidance

SKILLS:
- python-scientific: Vectorization, testing, profiling, memory optimization
- refactoring: triage, extract, qnew, qplan, qcode, catchup workflows

DOCUMENTATION:
- .claude/README.md: Playbook overview
- .claude/GETTING_STARTED.md: Setup guide
- .claude/WORKFLOW_GUIDE.md: Workflow documentation
- .claude/skills/README.md: Skills navigation hub
- CHANGELOG.md: Version history
- QUICK_REFERENCE.md: Daily development reference
- README.md: Updated with playbook integration

FILES: 17 new files, 1 updated file
PLAYBOOK: v4.0.0
DATE: 2024-12-18

Co-authored-by: Claude (Anthropic)
"@

if ($DryRun) {
    Write-Info "[DRY RUN] Would commit with message:"
    Write-Host $commitMessage -ForegroundColor Gray
} else {
    try {
        # Save commit message to temp file
        $tempFile = Join-Path $env:TEMP "commit-message.txt"
        $commitMessage | Out-File -FilePath $tempFile -Encoding UTF8
        
        git commit -F $tempFile
        
        Remove-Item $tempFile
        
        Write-Success "✓ Commit created successfully"
        
        # Show commit details
        Write-Info ""
        Write-Info "Commit details:"
        git log -1 --stat
    }
    catch {
        Write-Error "ERROR creating commit: $_"
        Pop-Location
        exit 1
    }
}

# Step 8: Push to GitHub
Write-Info "[8/8] Push to GitHub..."

if ($DryRun) {
    Write-Info "[DRY RUN] Would push to: origin/$Branch"
} else {
    Write-Warning ""
    Write-Warning "Ready to push to GitHub?"
    Write-Info "Branch: $Branch"
    Write-Info "Remote: origin"
    $response = Read-Host "Push now? (y/n)"
    
    if ($response -eq 'y') {
        try {
            git push origin $Branch
            Write-Success "✓ Pushed to GitHub successfully"
            
            Write-Info ""
            Write-Success "=========================================="
            Write-Success "SUCCESS! Playbook integration complete"
            Write-Success "=========================================="
            Write-Info ""
            Write-Info "Next steps:"
            Write-Info "1. View commit on GitHub: https://github.com/dyb5784/acp-simulation/commits/$Branch"
            Write-Info "2. Create pull request if on feature branch"
            Write-Info "3. Start using playbook: view .claude/skills/README.md"
            Write-Info ""
        }
        catch {
            Write-Error "ERROR pushing to GitHub: $_"
            Write-Warning "Commit was created locally but not pushed."
            Write-Info "You can push manually with: git push origin $Branch"
            Pop-Location
            exit 1
        }
    } else {
        Write-Info ""
        Write-Info "Commit created but not pushed."
        Write-Info "To push manually: git push origin $Branch"
    }
}

Pop-Location

Write-Info ""
Write-Success "Script completed successfully!"

# Summary
Write-Info ""
Write-Info "=========================================="
Write-Info "Summary"
Write-Info "=========================================="
Write-Info "Repository: $RepoPath"
Write-Info "Branch: $Branch"
Write-Info "Files staged: 17+ new files"
Write-Info "Commit: feat: Integrate Claude Code Playbook v4.0.0"
if (-not $DryRun) {
    Write-Info "Status: Committed $(if ($response -eq 'y') { 'and pushed' } else { 'locally (not pushed)' })"
} else {
    Write-Info "Status: DRY RUN - no changes made"
}
Write-Info "=========================================="
