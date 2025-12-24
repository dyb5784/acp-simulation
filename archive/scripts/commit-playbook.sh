#!/bin/bash
# commit-playbook.sh
# Automated commit script for Claude Code Playbook integration
# Version: 1.0
# Date: 2024-12-18

set -e  # Exit on error

# Configuration
REPO_PATH="${REPO_PATH:-/g/My Drive/acp-simulation}"
SOURCE_PATH="${SOURCE_PATH:-.}"
BRANCH="${BRANCH:-}"
DRY_RUN="${DRY_RUN:-false}"

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Helper functions
success() { echo -e "${GREEN}✓ $1${NC}"; }
info() { echo -e "${CYAN}$1${NC}"; }
warning() { echo -e "${YELLOW}WARNING: $1${NC}"; }
error() { echo -e "${RED}ERROR: $1${NC}"; exit 1; }

# Header
info "=========================================="
info "Claude Code Playbook Integration Script"
info "=========================================="
echo ""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --repo-path)
            REPO_PATH="$2"
            shift 2
            ;;
        --source-path)
            SOURCE_PATH="$2"
            shift 2
            ;;
        --branch)
            BRANCH="$2"
            shift 2
            ;;
        --dry-run)
            DRY_RUN="true"
            shift
            ;;
        *)
            echo "Usage: $0 [--repo-path PATH] [--source-path PATH] [--branch BRANCH] [--dry-run]"
            exit 1
            ;;
    esac
done

# Step 1: Verify repository
info "[1/8] Verifying repository location..."
if [ ! -d "$REPO_PATH" ]; then
    error "Repository not found at: $REPO_PATH"
fi

if [ ! -d "$REPO_PATH/.git" ]; then
    error "Not a git repository: $REPO_PATH"
fi

success "Repository found: $REPO_PATH"

# Step 2: Verify source files
info "[2/8] Verifying source files..."
required_files=(".claude" "README.md" "CONTEXT.md" "CHANGELOG.md" "QUICK_REFERENCE.md")

for file in "${required_files[@]}"; do
    if [ ! -e "$SOURCE_PATH/$file" ]; then
        error "Required file/directory not found: $file"
    fi
done

success "All source files present"

# Step 3: Check git status
info "[3/8] Checking git status..."
cd "$REPO_PATH"

current_branch=$(git branch --show-current)
if [ -z "$BRANCH" ]; then
    BRANCH="$current_branch"
fi

success "Current branch: $current_branch"
success "Will commit to: $BRANCH"

git_status=$(git status --porcelain)
if [ -n "$git_status" ] && [ "$DRY_RUN" = "false" ]; then
    warning "Repository has uncommitted changes:"
    echo "$git_status"
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        info "Aborted by user"
        exit 0
    fi
fi

# Step 4: Copy files
info "[4/8] Copying files to repository..."

if [ "$DRY_RUN" = "true" ]; then
    info "[DRY RUN] Would copy:"
    info "  - .claude/ directory"
    info "  - README.md"
    info "  - CONTEXT.md"
    info "  - CHANGELOG.md"
    info "  - QUICK_REFERENCE.md"
else
    # Backup existing .claude if exists
    if [ -d ".claude" ]; then
        backup_path=".claude.backup.$(date +%Y%m%d-%H%M%S)"
        warning "Backing up existing .claude directory to $backup_path"
        mv .claude "$backup_path"
    fi
    
    # Copy .claude directory
    cp -r "$SOURCE_PATH/.claude" .
    success "Copied .claude/ directory"
    
    # Copy root files
    for file in README.md CONTEXT.md CHANGELOG.md QUICK_REFERENCE.md; do
        if [ -f "$file" ]; then
            backup_path="$file.backup.$(date +%Y%m%d-%H%M%S)"
            cp "$file" "$backup_path"
        fi
        cp "$SOURCE_PATH/$file" .
        success "Copied $file"
    done
    
    success "All files copied successfully"
fi

# Step 5: Verify structure
info "[5/8] Verifying file structure..."

if [ "$DRY_RUN" = "false" ]; then
    expected_dirs=(
        ".claude"
        ".claude/skills"
        ".claude/skills/python-scientific"
        ".claude/skills/refactoring"
        ".claude/skills/refactoring/workflows"
    )
    
    for dir in "${expected_dirs[@]}"; do
        if [ ! -d "$dir" ]; then
            error "Expected directory not found: $dir"
        fi
    done
    
    file_count=$(find .claude -type f | wc -l)
    success "Structure verified: $file_count files in .claude/"
fi

# Step 6: Stage files
info "[6/8] Staging files..."

if [ "$DRY_RUN" = "true" ]; then
    info "[DRY RUN] Would stage files"
else
    git add .claude/
    git add README.md CONTEXT.md CHANGELOG.md QUICK_REFERENCE.md
    
    staged_count=$(git diff --cached --name-only | wc -l)
    success "Staged $staged_count files"
    
    info "Staged files:"
    git diff --cached --name-only | sed 's/^/  - /'
fi

# Step 7: Create commit
info "[7/8] Creating commit..."

commit_message="feat: Integrate Claude Code Playbook v4.0.0 for AI-assisted development

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

Co-authored-by: Claude (Anthropic)"

if [ "$DRY_RUN" = "true" ]; then
    info "[DRY RUN] Would commit with message:"
    echo "$commit_message"
else
    echo "$commit_message" | git commit -F -
    success "Commit created successfully"
    
    echo ""
    info "Commit details:"
    git log -1 --stat
fi

# Step 8: Push to GitHub
info "[8/8] Push to GitHub..."

if [ "$DRY_RUN" = "true" ]; then
    info "[DRY RUN] Would push to: origin/$BRANCH"
else
    echo ""
    warning "Ready to push to GitHub?"
    info "Branch: $BRANCH"
    info "Remote: origin"
    read -p "Push now? (y/n) " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git push origin "$BRANCH"
        success "Pushed to GitHub successfully"
        
        echo ""
        success "=========================================="
        success "SUCCESS! Playbook integration complete"
        success "=========================================="
        echo ""
        info "Next steps:"
        info "1. View commit: https://github.com/dyb5784/acp-simulation/commits/$BRANCH"
        info "2. Create pull request if on feature branch"
        info "3. Start using playbook: view .claude/skills/README.md"
        echo ""
    else
        echo ""
        info "Commit created but not pushed."
        info "To push manually: git push origin $BRANCH"
    fi
fi

echo ""
success "Script completed successfully!"

# Summary
echo ""
info "=========================================="
info "Summary"
info "=========================================="
info "Repository: $REPO_PATH"
info "Branch: $BRANCH"
info "Files staged: 17+ new files"
info "Commit: feat: Integrate Claude Code Playbook v4.0.0"
if [ "$DRY_RUN" = "true" ]; then
    info "Status: DRY RUN - no changes made"
else
    info "Status: Committed $([ "$REPLY" = "y" ] && echo "and pushed" || echo "locally (not pushed)")"
fi
info "=========================================="
