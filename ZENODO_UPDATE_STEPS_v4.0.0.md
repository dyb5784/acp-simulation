# Zenodo Update Steps: Claude Code Playbook v3.0.0 → v4.0.0

**DOI:** [10.5281/zenodo.17781760](https://doi.org/10.5281/zenodo.17781760)  
**Repository:** https://github.com/dyb5784/claude-code-playbook  
**Version:** 4.0.0  
**Date:** December 12, 2025

---

## 📋 Pre-Update Checklist

Before starting, verify you have:
- [ ] Zenodo account access
- [ ] GitHub repository access (https://github.com/dyb5784/claude-code-playbook)
- [ ] v4.0.0 tag created in GitHub repository
- [ ] All files ready for upload

---

## Step 1: Prepare v4.0.0 Release Files

### 1.1 Clone/Update Repository (if needed)
```bash
git clone https://github.com/dyb5784/claude-code-playbook.git
cd claude-code-playbook
git checkout v4.0.0
```

### 1.2 Verify v4.0.0 Tag Exists
```bash
git tag -l | grep v4.0.0
# Should show: v4.0.0
```

### 1.3 Create ZIP Archive of v4.0.0
```bash
# On Windows (in PowerShell or Command Prompt)
cd claude-code-playbook
zip -r claude-code-playbook-v4.0.0.zip . -x ".git/*" ".github/*"

# Or manually zip the following files/folders:
# - README.md
# - LICENSE
# - docs/
# - skills/
# - templates/
```

**Files to include (17 total):**
```
claude-code-playbook/
├── README.md
├── LICENSE
├── docs/
│   ├── GETTING_STARTED.md
│   └── WORKFLOW_GUIDE.md
├── skills/
│   ├── README.md
│   ├── python-scientific/
│   │   └── SKILL.md
│   └── refactoring/
│       ├── SKILL.md
│       ├── workflows/
│       │   ├── triage.md
│       │   ├── extract.md
│       │   ├── modernize.md
│       │   ├── qnew.md
│       │   ├── qplan.md
│       │   ├── qcode.md
│       │   └── catchup.md
│       └── knowledge/
│           ├── typescript-style.md
│           └── architecture-patterns.md
└── templates/
    ├── CLAUDE.md.template
    └── .cursorrules.template
```

---

## Step 2: Log into Zenodo

1. Go to https://zenodo.org/
2. Click **"Log in"** (top right)
3. Log in with your GitHub account
4. Go to **"Uploads"** → **"New version"** (next to your existing v3.0.0 entry)

---

## Step 3: Create New Version

### 3.1 Access Existing Record
1. Go to your existing record: https://zenodo.org/record/17781760
2. Click **"New version"** button
3. This will pre-fill many fields from v3.0.0

### 3.2 Update Basic Information

**Title:**
```
Practitioner's Playbook for Claude Code: Configuration for Token-Efficient AI Engineering (v4.0.0)
```

**Version:**
```
4.0.0
```

**Publication Date:**
```
2025-12-12
```

**Description** (copy from ZENODO_DESCRIPTION_v4.0.0.md):

```
# Practitioner's Playbook for Claude Code v4.0.0

**Token-Efficient AI Engineering Configuration**

---

## 🎯 What is v4.0.0?

Version 4.0.0 introduces a **complete, production-ready AI-assisted development system** that reduces conversation turns by 67% through specialized workflows and systematic development protocols.

### Key Features
1. **Two Specialized Skills**
   - Python Scientific Computing (NumPy/SciPy patterns)
   - General Refactoring (7 structured workflows)

2. **Seven Production Workflows**
   - `triage`, `extract`, `modernize`, `qnew`, `qplan`, `qcode`, `catchup`

3. **Project Templates**
   - `CLAUDE.md.template` - Project constitution
   - `.cursorrules.template` - IDE integration

4. **Comprehensive Documentation**
   - Getting started guide
   - Workflow usage instructions
   - Token economics and budget management
   - Session management protocols

---

## 📊 Token Efficiency Metrics

**Claude Pro Optimization:**
- **10-40 prompts** per 5-hour window
- **~44,000 tokens** total capacity
- **Example session**: 22K tokens (50% of budget)

**Workflow Costs:**
- triage: 2K | qnew: 2K | qplan: 3K | extract: 5K
- modernize: 4K | qcode: 8-12K | catchup: 1-2K

---

## 🚀 Quick Start

### Installation

1. **Clone the playbook:**
   ```bash
   git clone https://github.com/dyb5784/claude-code-playbook.git
   cd claude-code-playbook
   ```

2. **Copy templates to your project:**
   ```bash
   cp templates/CLAUDE.md.template /path/to/your/project/CLAUDE.md
   cp templates/.cursorrules.template /path/to/your/project/.cursorrules
   ```

3. **Customize the templates** for your project needs

4. **Start using Claude Code** with your project!

### Basic Usage

**Start a session:**
```bash
/clear
claude skills refactoring qnew
```

**Analyze codebase:**
```bash
claude skills refactoring triage
```

**Session management (every 5-7 prompts):**
```bash
/cost                              # Check token usage
/clear                             # Reset context
claude skills refactoring catchup  # Restore context
```

---

## 📚 Available Skills

### Python Scientific Computing
**Location**: `skills/python-scientific/SKILL.md`

**Best for:**
- Numerical simulations
- Statistical analysis
- Performance optimization
- Research code requiring reproducibility

**Key patterns:**
- Vectorization over loops
- Random seed management for reproducibility
- Type hints with `numpy.typing`
- Configuration management with dataclasses
- Parallel processing patterns
- Performance profiling

### General Refactoring
**Location**: `skills/refactoring/SKILL.md`

**Structured workflows for code quality improvement:**
- **triage**: Identify technical debt hotspots
- **extract**: Extract reusable components
- **modernize**: Update to modern patterns
- **qnew**: Quick new feature development
- **qplan**: Quick planning session
- **qcode**: Full implementation with verification
- **catchup**: Resume after context clear

**Use for:** Architectural changes, code organization, modernization

---

## 📖 Documentation Structure

```
claude-code-playbook/
├── README.md              # Overview and quick start
├── LICENSE                # MIT License
├── docs/                  # Documentation
│   ├── GETTING_STARTED.md # Step-by-step guide
│   └── WORKFLOW_GUIDE.md  # Detailed workflow usage
├── skills/                # Core skills directory
│   ├── README.md          # Skills overview
│   ├── python-scientific/ # Python scientific computing
│   │   └── SKILL.md       # Main skill file
│   └── refactoring/       # General refactoring
│       ├── SKILL.md       # Skill overview
│       ├── workflows/     # 7 workflow definitions
│       └── knowledge/     # Reference materials
└── templates/             # Project templates
    ├── CLAUDE.md.template
    └── .cursorrules.template
```

---

## 🎓 Learning Path

**Beginner (Sessions 1-2):**
1. Read `docs/GETTING_STARTED.md`
2. Run `claude skills refactoring qnew`
3. Use `triage` to understand your codebase
4. Extract 1 simple function with `extract`
5. Practice `/clear` + `catchup` protocol

**Intermediate (Sessions 3-10):**
1. Use `qplan` before extractions
2. Extract 2-3 functions per session
3. Apply `modernize` to update patterns
4. Track progress in `REFACTOR_PROGRESS.md`

**Advanced (Sessions 10+):**
1. Use `qcode` for batch operations (10-15 files)
2. Design custom extraction strategies
3. Contribute patterns back to knowledge base
4. Create new skills for your domain

---

## 📊 Success Metrics

**Code Quality Targets:**
- Lines per file: < 500
- Cyclomatic complexity: < 10
- Test coverage: > 80%
- Type hints: 100% for public APIs

**Process Metrics:**
- Token efficiency: Track actual vs. estimated
- Time to complete extraction
- Test failures per session: < 2
- Rework required: < 10%

---

## 📄 License

MIT License - see LICENSE file for details.

---

**Version**: 4.0.0  
**Date**: December 12, 2025  
**Repository**: https://github.com/dyb5784/claude-code-playbook
```

---

### 3.3 Update Keywords

Add these keywords (keep existing ones):
```
claude-code
ai-assisted-development
token-efficient
refactoring
python-scientific
workflows
kimi-for-coding
roo-code
```

### 3.4 Upload Files

1. Click **"Browse"** or drag-and-drop your ZIP file
2. Select: `claude-code-playbook-v4.0.0.zip`
3. Wait for upload to complete

### 3.5 Set Access Rights
- **Access right**: Creative Commons Attribution 4.0 International (CC BY 4.0)
- **License**: MIT (for code)

### 3.6 Related Identifiers

Add these links:
- **Repository**: https://github.com/dyb5784/claude-code-playbook
- **Previous version**: https://doi.org/10.5281/zenodo.17781760 (v3.0.0)

---

## Step 4: Review and Publish

### 4.1 Preview Your Entry
- Click **"Preview"** to see how it will look
- Verify all information is correct
- Check that files uploaded successfully

### 4.2 Save and Publish
1. Click **"Save"** (this creates a draft)
2. Review the draft one more time
3. Click **"Publish"** to make it public

---

## Step 5: Post-Update Verification

### 5.1 Verify DOI
- Your DOI remains: `10.5281/zenodo.17781760`
- The version number will be updated to v4.0.0
- Old versions remain accessible

### 5.2 Update GitHub Release
1. Go to: https://github.com/dyb5784/claude-code-playbook/releases
2. Edit the v4.0.0 release
3. Add Zenodo DOI link to release notes
4. Save changes

### 5.3 Update Documentation
Add Zenodo badge to README.md:
```markdown
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.17781760.svg)](https://doi.org/10.5281/zenodo.17781760)
```

---

## ✅ Final Checklist

- [ ] v4.0.0 files prepared and zipped
- [ ] Logged into Zenodo
- [ ] Created new version from v3.0.0
- [ ] Updated title to include v4.0.0
- [ ] Updated version number to 4.0.0
- [ ] Updated publication date
- [ ] Pasted complete description
- [ ] Updated keywords
- [ ] Uploaded v4.0.0 ZIP file
- [ ] Set correct license (CC BY 4.0)
- [ ] Added related identifiers (GitHub repo)
- [ ] Previewed entry
- [ ] Published new version
- [ ] Updated GitHub release with DOI
- [ ] Added Zenodo badge to README (optional)

---

## 📞 Need Help?

If you encounter issues:
1. Check Zenodo documentation: https://help.zenodo.org/
2. Verify file sizes (< 50GB per file, < 100GB total)
3. Ensure you're logged into the correct Zenodo account
4. Contact Zenodo support if technical issues persist

**Your Zenodo entry is now updated to v4.0.0!**