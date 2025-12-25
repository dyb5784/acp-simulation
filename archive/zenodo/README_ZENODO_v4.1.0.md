# 🛡️ Asymmetric Cognitive Projection (ACP) Simulation v4.1.0

**Practitioner's Playbook: Agentic Mesh Configuration for Kimi K2 & Roo Code**

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.17794644.svg)](https://doi.org/10.5281/zenodo.17794644)
[![Version](https://img.shields.io/badge/version-4.1.0-blue.svg)](https://github.com/dyb5784/acp-simulation/releases/tag/v4.1.0)
[![Python](https://img.shields.io/badge/python-3.8+-blue.svg)](https://www.python.org/downloads/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## 🎯 What's New in v4.1.0?

Version 4.1.0 introduces **Kimi K2-specific optimizations** that achieve 92% task completion rates while reducing token consumption by an additional 25% beyond v4.0.0 through agent-tuned model configuration and advanced context management strategies.

### Key Improvements Over v4.0.0

| Feature | v4.0.0 | v4.1.0 | Improvement |
|---------|--------|--------|-------------|
| **AI Provider** | Claude Code | Kimi K2 (kimi-for-coding) | Agent-tuned optimization |
| **Token Efficiency** | Baseline | +25% reduction | Context bias exploitation |
| **Task Completion** | 85% | 92% | 18-step horizon management |
| **Cost per 1M tokens** | $4.00 | $3.00 | $1.00 savings |
| **Reliability Horizon** | Not defined | 18 steps | Empirically validated |
| **Context Strategy** | Standard | Top/Tail bias | Strategic loading |

---

## 📦 Package Contents

This Zenodo package includes everything needed for production-ready ACP simulation with Kimi K2 integration:

### Core Simulation Engine
- **`src/acp_fully_configurable.py`** - Main CLI entry point with 7 configurable parameters
- **`src/acp_parallel_power_analysis.py`** - Statistical validation engine (1,000+ episodes)
- **`src/acp_corrected_final.py`** - Reference implementation (100 episodes)
- **`src/acp_simulation/`** - Complete modular package with agents, analysis, integration

### Kimi K2 Integration
- **`docs/PLAYBOOK.md`** - Complete Kimi K2 & Roo Code configuration guide
- **Agentic mesh configuration** - 18-step horizon management protocols
- **Context optimization strategies** - Top/tail bias exploitation patterns
- **Cost governance framework** - Reasoning token monitoring and alerts

### NIST Validation Tools
- **`scripts/run_acts.py`** - NIST ACTS/CCM integration CLI
- **`src/acp_simulation/integration/`** - Combinatorial testing orchestration
- **85 test configurations** - 100% 3-way coverage, 99.4% test reduction
- **Publication-ready results** - Thesis validation with statistical rigor

### Documentation & Guides
- **`docs/PLAYBOOK.md`** - Kimi K2 configuration (v4.1.0)
- **`docs/ACTS_INTEGRATION.md`** - NIST validation guide (600+ lines)
- **`docs/COMPREHENSIVE_GUIDE.md`** - Parameter documentation (637 lines)
- **`docs/QUICK_REFERENCE.md`** - Command reference (329 lines)
- **`docs/SETUP_GUIDE.md`** - Installation instructions
- **`docs/CHANGELOG.md`** - Complete version history

### Testing & Validation
- **`tests/`** - 13 comprehensive unit tests
- **`scripts/verify_reproducibility.py`** - Automated reproducibility verification
- **`pytest.ini`** - Testing configuration
- **Pre-commit hooks** - Code quality automation

---

## 🚀 Quick Start Guide

### 1. Installation

```bash
# Extract the package
unzip acp-simulation-v4.1.0.zip
cd acp-simulation-v4.1.0

# Install dependencies
pip install -r requirements.txt

# Verify installation
python src/check_setup.py
```

### 2. Configure Kimi K2 (Optional but Recommended)

```bash
# In Roo Code settings:
Provider: OpenAI Compatible
Base URL: https://api.kimi.com/coding/v1
Model ID: kimi-for-coding
Max Output: 16384
Reasoning: Medium
```

See `docs/PLAYBOOK.md` for complete configuration details.

### 3. Run Your First Simulation

```bash
# Quick test (100 episodes)
python src/acp_corrected_final.py

# Power analysis with statistical validation (1,000 episodes)
python src/acp_parallel_power_analysis.py

# Fully configurable simulation
python src/acp_fully_configurable.py --num-episodes 5000 --acp-strength 0.65
```

### 4. Run NIST Combinatorial Validation

```bash
# Complete parameter space validation (85 tests, ~2 hours)
python scripts/run_acts.py \
    --strength 3 \
    --acts-jar external/acts/acts_3.1.jar \
    --ccm-jar external/ccm/CCM17.jar \
    --output-dir ./validation_results
```

---

## 📊 Expected Results

### Statistical Validation (v4.0.0 Baseline)
- **Achieved Power**: 100.0% (exceeds 95% threshold)
- **Effect Size**: Cohen's d = 5.447 (extremely large effect)
- **Statistical Significance**: p < 10⁻¹⁶ (highly significant)
- **Sample Size**: 500+ episodes per group

### Performance Metrics (v4.1.0 Improvements)
- **Task Completion Rate**: 92% (vs 85% baseline)
- **Token Efficiency**: 25% reduction through context optimization
- **Cost Savings**: $1.00 per 1M tokens
- **Reliability**: Maintained through 18-step horizon management

### NIST Validation Results
- **Test Configurations**: 85 (vs 13,824 exhaustive)
- **Runtime**: ~2 hours (vs 347 hours exhaustive)
- **Coverage**: 100% 3-way parameter interactions
- **Success Rate**: 100% (85/85 tests show ACP superiority)
- **Average Improvement**: +42.3% reward (ACP vs Traditional)

---

## 📖 Documentation Structure

```
acp-simulation-v4.1.0/
├── README_ZENODO_v4.1.0.md          # This file - Zenodo entry point
├── VERSION_CHANGELOG.md             # Version history and changes
├── requirements.txt                 # Python dependencies
├── setup.py                         # Package installation
│
├── docs/                            # Comprehensive documentation
│   ├── PLAYBOOK.md                  # Kimi K2 configuration guide (v4.1.0)
│   ├── ACTS_INTEGRATION.md          # NIST validation (600+ lines)
│   ├── COMPREHENSIVE_GUIDE.md       # Parameter documentation (637 lines)
│   ├── QUICK_REFERENCE.md           # Command reference (329 lines)
│   ├── CHANGELOG.md                 # Complete version history
│   ├── SETUP_GUIDE.md               # Installation instructions
│   ├── QUICK_START_WINDOWS.md       # Windows-specific guide
│   ├── INSTALLATION_FIX.md          # Troubleshooting
│   ├── AI_ASSISTED_DEVELOPMENT.md   # AI integration guide
│   ├── CLAUDE_CODE_INTEGRATION.md   # Legacy Claude integration
│   ├── research_validation_workflow.md # Research methodology
│   └── USE_CASES.md                 # Practical examples
│
├── src/                             # Source code
│   ├── acp_fully_configurable.py    # Main CLI (v3.0+)
│   ├── acp_parallel_power_analysis.py # Statistical engine
│   ├── acp_corrected_final.py       # Reference implementation
│   ├── parameter_sweep.py           # Sensitivity analysis
│   ├── explain_results.py           # Results interpretation
│   ├── check_setup.py               # Installation verification
│   └── acp_simulation/              # Modular package
│       ├── __init__.py
│       ├── agents/                  # Attacker/Defender implementations
│       ├── analysis/                # Statistics & visualization
│       ├── core/                    # Data classes & types
│       ├── environment/             # Network simulation
│       ├── integration/             # NIST ACTS/CCM integration
│       └── simulation/              # Core simulation runner
│
├── scripts/                         # Utility scripts
│   ├── run_acts.py                  # NIST validation CLI
│   ├── verify_reproducibility.py    # Reproducibility testing
│   ├── latency_sweep_config.py      # Latency analysis
│   └── test_latency_reproducibility.py
│
├── tests/                           # Test suite
│   ├── conftest.py
│   ├── test_core_dataclasses.py
│   ├── test_core_enums.py
│   ├── test_integration_acts_generator.py
│   ├── test_integration_acts_runner.py
│   ├── test_integration_ccm_analyzer.py
│   └── test_simulation_runner.py
│
├── examples/                        # Example configurations
│   └── (example parameter files)
│
└── external/                        # External tools
    └── acts/                        # NIST ACTS/CCM tools
        ├── acts_3.1.jar
        ├── acts_cli.jar
        └── ccm/
            └── CCM17.jar
```

---

## 🔧 Kimi K2 Configuration

### Roo Code Provider Settings

| Setting | Value | Rationale |
|---------|-------|-----------|
| **Provider** | `OpenAI Compatible` | Standard protocol support |
| **Base URL** | `https://api.kimi.com/coding/v1` | **Critical:** Agent-tuned endpoint |
| **API Key** | `sk-kimi-...` | From Kimi Membership Dashboard |
| **Model ID** | `kimi-for-coding` | Optimized for 18+ step loops |
| **Max Output** | `16384` | Efficiency sweet spot |
| **Reasoning** | `Medium` | Maps to "Thinking" profile |

### Context Management Strategy

**Top Bias Exploitation (First 25%):**
```bash
# Load these files FIRST in your session
/clear
# Load architecture and configuration files
claude skills python-scientific qnew
```

**Tail Bias Exploitation (Last 25%):**
```bash
# Keep these at the END of your context
# Current error logs
# Recent conversation history
# Immediate task reminders
```

### Reasoning Toggle Protocol

**Medium Reasoning (Default):**
- Complex refactoring tasks
- Architecture design decisions
- Multi-file coordination
- Performance optimization

**Low Reasoning (Turbo):**
- Test writing
- Code formatting
- Documentation generation
- Simple bug fixes

---

## 📊 Usage Examples

### Basic Simulation

```bash
# Quick validation test
python src/acp_corrected_final.py

# Standard power analysis
python src/acp_parallel_power_analysis.py

# Custom parameter exploration
python src/acp_fully_configurable.py \
    --acp-strength 0.7 \
    --num-episodes 10000 \
    --num-nodes 100 \
    --learning-rate 1.5
```

### Parameter Sweep Analysis

```bash
# Full sensitivity analysis
python src/parameter_sweep.py

# Single parameter exploration
python src/parameter_sweep.py acp_strength
python src/parameter_sweep.py learning_rate
```

### NIST Combinatorial Testing

```bash
# Install NIST tools (see docs/ACTS_INTEGRATION.md)
# Then run comprehensive validation:
python scripts/run_acts.py \
    --strength 3 \
    --acts-jar external/acts/acts_3.1.jar \
    --ccm-jar external/ccm/CCM17.jar \
    --output-dir ./validation_results

# View coverage report
cat validation_results/coverage_report.txt
```

---

## 🎓 Citation

If you use this simulation in your research, please cite:

```bibtex
@software{acp_simulation_2025,
  title={Asymmetric Cognitive Projection Simulation: Beyond Paralysis},
  author={dyb},
  year={2025},
  month={December},
  version={4.1.0},
  url={https://github.com/dyb5784/acp-simulation},
  doi={10.5281/zenodo.17794644}
}
```

For the Kimi K2 configuration playbook specifically:

```bibtex
@misc{kimi_k2_playbook_2025,
  title={Practitioner's Playbook: Agentic Mesh Configuration for Kimi K2 & Roo Code},
  author={dyb},
  year={2025},
  version={4.1.0},
  url={https://github.com/dyb5784/acp-simulation},
  doi={10.5281/zenodo.17794644}
}
```

---

## 📞 Support & Resources

### Documentation
- **Complete Guide**: `docs/COMPREHENSIVE_GUIDE.md` (637 lines)
- **Quick Reference**: `docs/QUICK_REFERENCE.md` (329 lines)
- **Kimi K2 Playbook**: `docs/PLAYBOOK.md` (v4.1.0 specific)
- **NIST Integration**: `docs/ACTS_INTEGRATION.md` (600+ lines)

### Troubleshooting
- **Installation Issues**: `docs/INSTALLATION_FIX.md`
- **Setup Guide**: `docs/SETUP_GUIDE.md`
- **Windows Guide**: `docs/QUICK_START_WINDOWS.md`

### Community
- **GitHub Repository**: https://github.com/dyb5784/acp-simulation
- **Issues**: https://github.com/dyb5784/acp-simulation/issues
- **Releases**: https://github.com/dyb5784/acp-simulation/releases

---

## 🔄 Version History

- **v4.1.0** (Current): Kimi K2 optimizations, 25% token reduction, 92% task completion
- **v4.0.0**: NIST ACTS/CCM integration, combinatorial testing, 85 test configurations
- **v3.0.0**: Fully configurable parameters, automated sweeps, research-grade documentation
- **v2.0.0**: Parallel power analysis, statistical validation, cross-platform support
- **v1.0.0**: Initial ACP implementation, IBLT attacker model, basic validation

---

## 📄 License

MIT License - see LICENSE file for details.

---

**Version**: 4.1.0  
**Date**: December 12, 2025  
**Status**: ✅ Production Ready  
**Platform**: Cross-platform (Windows, Linux, macOS)  
**DOI**: [10.5281/zenodo.17794644](https://doi.org/10.5281/zenodo.17794644)  
**Repository**: https://github.com/dyb5784/acp-simulation

---

*This Zenodo entry contains the complete ACP Simulation v4.1.0 package with Kimi K2 integration, NIST validation tools, and comprehensive documentation for research and production use.*