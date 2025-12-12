# Practitioner's Playbook for Claude Code v4.0.0

**Token-Efficient AI Engineering Configuration**

---

## 🎯 What is v4.0.0?

Version 4.0.0 introduces a **complete, production-ready AI-assisted development system** that reduces conversation turns by 67% through specialized workflows and systematic development protocols.

### Key Features

**1. Two Specialized Skills**
- **Python Scientific Computing**: Research-grade patterns for NumPy/SciPy development
- **General Refactoring**: 7 structured workflows for code modernization

**2. Seven Production Workflows**
- `triage` - Identify technical debt hotspots
- `extract` - Extract reusable components  
- `modernize` - Update to modern patterns
- `qnew` - Quick session initialization
- `qplan` - Validate refactoring plans
- `qcode` - Batch implementation (up to 15 files)
- `catchup` - Resume after context reset

**3. Project Templates**
- `CLAUDE.md.template` - Project constitution framework
- `.cursorrules.template` - IDE integration rules

**4. Comprehensive Documentation**
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
- triage: 2K tokens
- qnew: 2K tokens
- qplan: 3K tokens
- extract: 5K tokens
- modernize: 4K tokens
- qcode: 8-12K tokens
- catchup: 1-2K tokens

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

3. **Customize for your project:**
   - Edit `CLAUDE.md` with your project-specific constraints
   - Update `.cursorrules` for your tech stack

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

**Extract a function:**
```bash
claude skills refactoring extract
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
- Random seed management
- Type hints with `numpy.typing`
- Configuration with dataclasses
- Parallel processing
- Performance profiling

### General Refactoring
**Location**: `skills/refactoring/SKILL.md`

**Best for:**
- Code organization
- Technical debt reduction
- Modernizing legacy code
- Architectural improvements

**Workflows:**
- **triage**: Find top 3 debt hotspots
- **extract**: Break down code systematically
- **modernize**: Update to current patterns
- **qnew**: Fresh session initialization
- **qplan**: Validate approach before coding
- **qcode**: Batch implementation
- **catchup**: Resume after context clear

---

## 📖 Documentation Structure

```
claude-code-playbook/
├── README.md              # Overview and quick start
├── skills/
│   ├── README.md          # Skill selection guide
│   ├── python-scientific/
│   │   └── SKILL.md       # Python scientific patterns
│   └── refactoring/
│       ├── SKILL.md       # Refactoring overview
│       ├── workflows/     # 7 workflow files
│       └── knowledge/     # Reference materials
├── templates/             # Project templates
├── docs/
│   ├── GETTING_STARTED.md # Step-by-step guide
│   └── WORKFLOW_GUIDE.md  # Detailed workflow usage
└── LICENSE                # MIT License
```

---

## 🎓 Learning Path

**Beginner (Sessions 1-2):**
1. Read `docs/GETTING_STARTED.md`
2. Run `claude skills refactoring qnew`
3. Use `triage` to understand your codebase
4. Extract 1 simple function

**Intermediate (Sessions 3-10):**
1. Use `qplan` before extractions
2. Extract 2-3 functions per session
3. Apply `modernize` to update patterns
4. Track progress

**Advanced (Sessions 10+):**
1. Use `qcode` for batch operations
2. Design custom strategies
3. Contribute patterns back

---

## 🔧 Integration with Your Project

### Step 1: Copy Templates
```bash
cp templates/CLAUDE.md.template ./CLAUDE.md
cp templates/.cursorrules.template ./.cursorrules
```

### Step 2: Customize CLAUDE.md
Update:
- Project name and description
- Token budget constraints
- Validation requirements
- Coding standards

### Step 3: Start Using
```bash
/clear
claude skills refactoring qnew
```

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

## 🐛 Troubleshooting

**Workflow not found:**
- Verify playbook directory structure
- Check you're in project root with CLAUDE.md

**High token usage:**
- Use `/clear` + `catchup` more frequently
- Reduce batch sizes
- Focus on one pattern at a time

**Poor quality suggestions:**
- Verify CLAUDE.md is customized
- Ensure session reset protocol
- Check appropriate skill loaded

---

## 📄 License

MIT License - see LICENSE file for details.

---

**Version**: 4.0.0  
**Date**: December 11, 2025  
**Repository**: https://github.com/dyb5784/claude-code-playbook  
**Citation**: Practitioner's Playbook for Claude Code: Configuration for Token-Efficient AI Engineering