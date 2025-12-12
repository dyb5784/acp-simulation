# Claude Code Playbook - Claude App for Windows Setup Guide

This guide explains how to use the Claude Code Playbook with the Claude desktop application.

## 📋 What Goes Where in Claude App

When you create a project in Claude App for Windows, you'll see three sections:

### 1. Memory (Only you)
**What to put here:** Project-specific context that persists across conversations

**Example:**
```
Project: ACP Simulation v4.0
- Python 3.8+ scientific computing project
- NumPy/SciPy/NetworkX/Matplotlib
- Research-grade statistical validation required
- Token budget: 44K per session (Claude Pro)
- Always verify reproducibility with fixed seeds
```

### 2. Instructions
**What to put here:** How to use the playbook and your development workflow

**Copy and paste this:**

```
## Claude Code Playbook Usage

You are using the Claude Code Playbook v4.0.0 for AI-assisted development.

### Session Start Protocol
1. Always begin with: `/clear` then `claude skills refactoring qnew`
2. Load appropriate skill before coding:
   - For simulation/numerical work: `view skills/python-scientific/SKILL.md`
   - For refactoring/architecture: `view skills/refactoring/SKILL.md`
3. Check token budget: `/cost` every 3 prompts

### Development Workflow
1. **Triage**: `claude skills refactoring triage` (find debt hotspots)
2. **Plan**: `claude skills refactoring qplan` (validate approach)
3. **Extract**: `claude skills refactoring extract` (break down code)
4. **Modernize**: `claude skills refactoring modernize` (update patterns)
5. **Reset**: `/clear` + `claude skills refactoring catchup` (every 5-7 prompts)

### Validation Requirements (CRITICAL)
Before ANY code changes, verify:
- [ ] Type checking passes: `mypy src/ --strict`
- [ ] Linting passes: `flake8 src/ --max-line-length=100`
- [ ] Tests pass: `pytest tests/ -v`
- [ ] Reproducibility verified: `python scripts/verify_reproducibility.py`

### Code Quality Standards
- Vectorize operations (no loops over arrays)
- Add type hints with numpy.typing
- Use dataclasses for configuration
- Set explicit random seeds
- Write NumPy-style docstrings

### Token Management
- **Budget**: ~44,000 tokens per 5-hour session
- **Target**: 10-40 prompts per session
- **Reset**: Every 5-7 prompts, execute `/clear` + `catchup`
- **Track**: Use `/cost` to monitor usage

STOP if validation fails. Fix issues before proceeding.
```

### 3. Files (Add PDFs, documents, or other text to reference)
**What to put here:** The Claude Code Playbook files

**Follow these steps:**

#### Step 1: Clone the playbook (if you haven't already)
```bash
git clone https://github.com/dyb5784/claude-code-playbook.git
cd claude-code-playbook
```

#### Step 2: Add these files to your Claude App project:

**Essential Files (add these first):**
1. `README.md` - Overview and quick start
2. `skills/README.md` - Skill selection guide
3. `skills/python-scientific/SKILL.md` - Python scientific patterns
4. `skills/refactoring/SKILL.md` - Refactoring workflows
5. `docs/GETTING_STARTED.md` - Step-by-step guide
6. `docs/WORKFLOW_GUIDE.md` - Detailed usage

**Optional Files (add if needed):**
7. `skills/refactoring/workflows/triage.md` - Debt analysis
8. `skills/refactoring/workflows/extract.md` - Extraction guide
9. `skills/refactoring/workflows/modernize.md` - Modernization
10. `templates/CLAUDE.md.template` - Project constitution template

#### Step 3: In Claude App, click "Add Files" and select the files from step 2

## 🎯 How to Use in a Session

### Starting Your First Session

1. **Open your project** in Claude App
2. **Type**: `/clear` (resets context)
3. **Type**: `claude skills refactoring qnew` (initializes session)
4. **Type**: `claude skills refactoring triage` (analyzes codebase)
5. **Review** the files Claude references (you'll see citations)

### During Development

**Every 5-7 prompts:**
```bash
/cost                              # Check token usage
/clear                             # Reset context
claude skills refactoring catchup  # Restore session
```

**To work on code:**
```bash
# Load skill first
view skills/python-scientific/SKILL.md

# Then ask your question
"How do I vectorize this loop?"
```

**To refactor:**
```bash
claude skills refactoring extract
# Claude will guide you through extraction
```

## 📊 What Success Looks Like

**Good signs:**
- ✅ Claude references the playbook files (you'll see [1], [2], etc.)
- ✅ Suggestions follow patterns from SKILL.md files
- ✅ Token usage stays within budget
- ✅ Code passes all validation checks

**If Claude doesn't reference the files:**
- Make sure files are added to the project
- Try: "Please reference the Claude Code Playbook skills"
- Check that files uploaded successfully

## 🐛 Troubleshooting

**"Claude isn't using the playbook patterns"**
- Solution: Start session with `view skills/python-scientific/SKILL.md` to load patterns

**"High token usage"**
- Solution: Use `/clear` + `catchup` every 5-7 prompts religiously

**"Suggestions don't match my project"**
- Solution: Customize the CLAUDE.md.template before adding to project

**"Files aren't being referenced"**
- Solution: Re-upload files to Claude App project

## 📁 Complete Setup Checklist

- [ ] Memory section filled with project context
- [ ] Instructions section copied from above
- [ ] README.md added to Files
- [ ] skills/README.md added to Files
- [ ] skills/python-scientific/SKILL.md added to Files
- [ ] skills/refactoring/SKILL.md added to Files
- [ ] docs/GETTING_STARTED.md added to Files
- [ ] Test with: `/clear` + `claude skills refactoring qnew`

## 💡 Pro Tips

1. **Start small**: Extract 1-2 functions per session
2. **Validate constantly**: Run tests after each change
3. **Track progress**: Keep a REFACTOR_PROGRESS.md file
4. **Commit often**: Every 2-4 files, commit your work
5. **Use the right skill**: Python Scientific for simulation, Refactoring for architecture

---

**Need help?** Open an issue at https://github.com/dyb5784/claude-code-playbook