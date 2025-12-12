# Claude App Setup - Next Steps (Action Plan)

Follow these steps in order to set up the Claude Code Playbook v4.0.0 with your BSI project.

---

## Step 1: Add CONTEXT.md to Claude App

**File to add**: `g:\My Drive\acp-simulation\CONTEXT.md`

**How to add:**
1. Open your BSI project in Claude App for Windows
2. Click **"Add Files"** button in the Files section
3. Navigate to `g:\My Drive\acp-simulation\`
4. Select `CONTEXT.md`
5. Click **"Open"**
6. Verify it appears in the Files list

**What this does**: Gives Claude project-specific context about ACP Simulation architecture and constraints.

---

## Step 2: Add the 9 Playbook Files

**Files to add** (from `g:\My Drive\claude-code-playbook\`):

1. `README.md`
2. `skills/README.md`
3. `skills/python-scientific/SKILL.md`
4. `skills/refactoring/SKILL.md`
5. `docs/GETTING_STARTED.md`
6. `docs/WORKFLOW_GUIDE.md`
7. `skills/refactoring/workflows/triage.md`
8. `skills/refactoring/workflows/extract.md`
9. `skills/refactoring/workflows/modernize.md`

**How to add:**
1. In the same BSI project, click **"Add Files"** again
2. Navigate to `g:\My Drive\claude-code-playbook\`
3. **Hold Ctrl** and select all 9 files listed above
4. Click **"Open"**
5. Verify all 9 files appear in the Files list

**What this does**: Provides Claude with the complete Claude Code Playbook v4.0.0 for AI-assisted development.

---

## Step 3: Copy Style Section

**Where to put it**: In the "Style" section of your Claude App project

**Content to copy:**

```
## Response Style

- Provide direct, actionable answers
- Include code examples when relevant
- Reference playbook files by name
- Ask clarifying questions if needed

## Code Style

- Vectorized NumPy operations (no Python loops)
- Type hints with numpy.typing (NDArray[np.float64])
- NumPy-style docstrings
- Configuration via dataclasses
- Explicit random seeds for reproducibility
```

**How to add:**
1. Click in the "Style" text box
2. Paste the content above
3. Click outside the box to save

---

## Step 4: Copy Instructions Section

**Where to put it**: In the "Instructions" section of your Claude App project

**Content to copy:**

```
## BSI Project Context

- Python scientific computing project
- NumPy/SciPy/NetworkX/Matplotlib
- Statistical validation with power analysis
- Token budget: 44K per session (Claude Pro)
- Must verify reproducibility with fixed seeds

## Claude Code Playbook Usage

### Session Start
1. /clear
2. claude skills refactoring qnew
3. view skills/python-scientific/SKILL.md

### Development Workflow
1. claude skills refactoring triage
2. claude skills refactoring qplan
3. claude skills refactoring extract
4. claude skills refactoring modernize
5. /clear + claude skills refactoring catchup (every 5-7 prompts)

### Validation (CRITICAL - must pass before commit)
- mypy src/ --strict
- flake8 src/ --max-line-length=100
- pytest tests/ -v
- python scripts/verify_reproducibility.py

### Token Management
- Check /cost every 3 prompts
- Reset every 5-7 prompts
- STOP if validation fails
```

**How to add:**
1. Click in the "Instructions" text box
2. Paste the content above
3. Click outside the box to save

---

## Step 5: Start Your First Session

**Commands to type (in order):**

1. **`/clear`** - Resets context
2. **`claude skills refactoring qnew`** - Initializes session with playbook
3. **`claude skills refactoring triage`** - Analyzes codebase for debt hotspots

**What to look for:**
- ✅ Claude references files (shows [1], [2], [3], etc.)
- ✅ Mentions "Claude Code Playbook patterns"
- ✅ Suggestions include vectorization, type hints, etc.

**If no file references appear:**
- Try: "Please reference the uploaded playbook files"
- Verify all files appear in the Files list
- Re-upload any missing files

---

## ✅ Final Verification Checklist

Before starting development, verify:

- [ ] CONTEXT.md appears in Files list
- [ ] All 9 playbook files appear in Files list
- [ ] Style section contains response and code style guidelines
- [ ] Instructions section contains BSI context and workflow
- [ ] Tested with `/clear` + `claude skills refactoring qnew`
- [ ] Claude references files in its responses

---

## 🚀 You're Ready!

Once all steps are complete, you can start using the Claude Code Playbook for AI-assisted development on your BSI project.

**Next development task example:**
```bash
# After setup is complete
claude skills refactoring triage          # Find debt hotspots
# or
view skills/python-scientific/SKILL.md   # Load Python patterns
# then ask your specific question
```

**Need help?** Reference: `CLUADE_APP_WINDOWS_PRACTICAL_GUIDE.md`