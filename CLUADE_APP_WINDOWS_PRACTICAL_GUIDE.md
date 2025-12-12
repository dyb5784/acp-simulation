# Claude Code Playbook - Claude App for Windows (Practical Setup)

**For your BSI project** - Minimal, actionable setup

---

## ⚠️ Important: Memory Section Limitation

**You CANNOT edit the Memory section directly** in Claude App for Windows - it populates automatically after a few chats.

**Workaround:** Put project context in the **Instructions** section instead. Claude will learn and populate Memory over time.

---

## 🎯 What Goes Where (Exact Files for BSI Project)

### Section 1: Style (Add to Style)
**Purpose**: How Claude should respond and format code

**Copy this exactly:**

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

### Section 2: Instructions (Add to Instructions)
**Purpose**: Your development workflow and playbook usage

**Copy this exactly:**

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

### Section 3: Files (Add these exact files)
**Purpose**: The Claude Code Playbook reference files

**Add all 9 files (6 essential + 3 optional):**

1. **`README.md`** (from `g:\My Drive\claude-code-playbook\`)
   - Overview and quick start

2. **`skills/README.md`** (from `g:\My Drive\claude-code-playbook\skills\`)
   - Skill selection guide

3. **`skills/python-scientific/SKILL.md`** (from `g:\My Drive\claude-code-playbook\skills\python-scientific\`)
   - Python scientific patterns (vectorization, reproducibility, etc.)

4. **`skills/refactoring/SKILL.md`** (from `g:\My Drive\claude-code-playbook\skills\refactoring\`)
   - Refactoring workflows overview

5. **`docs/GETTING_STARTED.md`** (from `g:\My Drive\claude-code-playbook\docs\`)
   - Step-by-step usage guide

6. **`docs/WORKFLOW_GUIDE.md`** (from `g:\My Drive\claude-code-playbook\docs\`)
   - Detailed workflow documentation

7. **`skills/refactoring/workflows/triage.md`** (from `g:\My Drive\claude-code-playbook\skills\refactoring\workflows\`)
   - Detailed debt analysis guide

8. **`skills/refactoring/workflows/extract.md`** (from `g:\My Drive\claude-code-playbook\skills\refactoring\workflows\`)
   - Step-by-step extraction guide

9. **`skills/refactoring/workflows/modernize.md`** (from `g:\My Drive\claude-code-playbook\skills\refactoring\workflows\`)
   - Pattern modernization guide

**Why add all 9?** The detailed workflow guides provide deeper context that helps Claude give more precise suggestions, especially for complex refactoring tasks. The extra token cost is minimal compared to the improved guidance.

---

## 📂 Exact File Paths for Your BSI Project

```
g:\My Drive\claude-code-playbook\README.md
g:\My Drive\claude-code-playbook\skills\README.md
g:\My Drive\claude-code-playbook\skills\python-scientific\SKILL.md
g:\My Drive\claude-code-playbook\skills\refactoring\SKILL.md
g:\My Drive\claude-code-playbook\docs\GETTING_STARTED.md
g:\My Drive\claude-code-playbook\docs\WORKFLOW_GUIDE.md
g:\My Drive\claude-code-playbook\skills\refactoring\workflows\triage.md
g:\My Drive\claude-code-playbook\skills\refactoring\workflows\extract.md
g:\My Drive\claude-code-playbook\skills\refactoring\workflows\modernize.md
```

---

## 🎯 How to Add Files in Claude App

1. Open your BSI project in Claude App for Windows
2. Click **"Add Files"** button (in the Files section)
3. Navigate to `g:\My Drive\claude-code-playbook\`
4. Select all 9 files listed above (hold Ctrl to select multiple)
5. Click **"Open"** to upload them
6. Verify they appear in the Files list

---

## 🚀 Your First Session (Step-by-Step)

1. **Setup complete?** (Style, Instructions, and 9 files added)
2. **Type exactly**: `/clear`
3. **Type exactly**: `claude skills refactoring qnew`
4. **Type exactly**: `claude skills refactoring triage`
5. **Look for**: Claude should reference the files (shows [1], [2], etc.)
6. **If no references**: Try "Please use the Claude Code Playbook patterns"

---

## 📊 What Success Looks Like

**Good signs:**
- ✅ Claude says "I'll use the Claude Code Playbook patterns"
- ✅ You see file references like [1], [2] in responses
- ✅ Suggestions include vectorization, type hints, etc.
- ✅ Token usage stays reasonable

**If Claude doesn't reference files:**
- Re-upload the files
- Try: "Please reference skills/python-scientific/SKILL.md"
- Check that files appear in the Files list

---

## 💡 Pro Tips for BSI Project

**For simulation work:**
```bash
# Always start here
view skills/python-scientific/SKILL.md

# Then ask specific questions
"How do I vectorize this agent update loop?"
"What's the best way to add type hints to this function?"
```

**For refactoring:**
```bash
# Find issues first
claude skills refactoring triage

# Then extract
claude skills refactoring extract
```

**Token management:**
```bash
# Every 3 prompts
/cost

# Every 5-7 prompts
/clear
claude skills refactoring catchup
```

---

## 🐛 Quick Troubleshooting

**"Claude isn't using the playbook"**
- Make sure all 6 files are uploaded
- Try: "Please use the Claude Code Playbook patterns from the uploaded files"

**"Token usage is high"**
- Use `/clear` + `catchup` more frequently
- Reduce batch sizes

**"Suggestions don't match BSI project"**
- Add more project context to Instructions section
- Mention specific libraries (NumPy, SciPy, etc.)

---

## ✅ Setup Checklist

- [ ] Style section filled in
- [ ] Instructions section copied
- [ ] README.md uploaded
- [ ] skills/README.md uploaded
- [ ] skills/python-scientific/SKILL.md uploaded
- [ ] skills/refactoring/SKILL.md uploaded
- [ ] docs/GETTING_STARTED.md uploaded
- [ ] docs/WORKFLOW_GUIDE.md uploaded
- [ ] skills/refactoring/workflows/triage.md uploaded
- [ ] skills/refactoring/workflows/extract.md uploaded
- [ ] skills/refactoring/workflows/modernize.md uploaded
- [ ] Tested with `/clear` + `claude skills refactoring qnew`

---

**Need help?** Open an issue at https://github.com/dyb5784/claude-code-playbook