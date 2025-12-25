# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**ACP Simulation** is a Python-based research codebase implementing Asymmetric Cognitive Projection (ACP) strategies for cybersecurity defense validation. The simulation models cognitive attacker-defender dynamics on network graphs with instance-based learning attackers and strategic defenders exploiting cognitive latency windows.

**Version**: 4.0.0
**Python**: 3.8+
**Core Dependencies**: numpy, scipy, networkx, matplotlib

## Development Commands

### Testing
```bash
# Run all tests
pytest tests/ -v

# Run specific test markers
pytest tests/ -m unit
pytest tests/ -m integration
pytest tests/ -m "not slow"

# Run with coverage
pytest tests/ --cov=src/acp_simulation --cov-report=html
```

### Linting and Type Checking
```bash
# Format code
black src/ tests/ --line-length=100
isort src/ tests/ --profile black --line-length=100

# Lint
flake8 src/ --max-line-length=100 --extend-ignore=E203,W503

# Type check
mypy src/ --strict --ignore-missing-imports
```

### Reproducibility Validation
```bash
# Critical for ACP research: verify deterministic simulation behavior
python scripts/verify_reproducibility.py
```

### Pre-commit Hooks
```bash
# Install pre-commit (first time only)
pip install pre-commit
pre-commit install

# Run all checks manually
pre-commit run --all-files
```

### Running Simulations
```bash
# Primary CLI entry point (configurable)
python src/acp_fully_configurable.py --episodes 100 --seed 42

# Legacy reference implementation
python src/acp_corrected_final.py

# Parameter sweeps
python src/parameter_sweep.py

# Statistical power analysis
python acp_parallel_power_analysis.py
```

## Architecture

### Package Structure
```
src/acp_simulation/
├── core/              # Core data structures and types
│   ├── enums.py       # NodeState, ActionType enumerations
│   ├── dataclasses.py # Instance, SimulationConfig
│   └── types.py       # AgentState, RewardArray, EpisodeResult
├── agents/            # Agent implementations
│   ├── base.py        # BaseAttacker, BaseDefender abstract classes
│   ├── attacker.py    # CognitiveAttacker (IBLT learning)
│   └── defender.py    # Pessimistic, ACP defender strategies
├── environment/       # Simulation environment
│   └── network.py     # NetworkEnvironment (⚠️ 330 lines, refactor target)
├── simulation/        # Experiment execution
│   └── runner.py      # Episode/experiment runners, parallel support
├── analysis/          # Post-simulation analysis
│   ├── statistics.py  # Statistical validation (Cohen's d, p-values)
│   └── visualization.py
└── integration/       # External framework integration
    ├── acts/          # ACTS combinatorial testing
    └── ccm/           # CCM integration
```

### Key Design Patterns

**1. Cognitive Latency Window**
The core ACP mechanism: defenders act during the attacker's "processing window" (cognitive delay). This is implemented in `NetworkEnvironment` via multi-phase execution:
- Phase 1: Attacker selects target → processing delay begins
- Phase 2: Defender observes and acts during delay
- Phase 3: Attacker action executes on final state

**2. Seed-Based Reproducibility**
All randomness flows through explicit `random_seed` parameters using `numpy.random.default_rng()`. Global random state (`np.random.rand()`) is **forbidden**.

**3. Vectorization Over Loops**
Performance-critical agent decision logic should use NumPy vector operations instead of Python loops.

## Critical Operational Constraints

### 1. Statistical Rigor
All performance claims must report **Cohen's d** (effect size) and **p-values** (statistical significance). Do not merge code that degrades statistical power below 80%.

### 2. Reproducibility
- All simulations accept explicit `random_seed` parameters
- Use `numpy.random.default_rng(seed)` for RNG creation
- Never use global random state (`np.random.rand()`, `random.random()`)
- Verify reproducibility with: `python scripts/verify_reproducibility.py`

### 3. Type Safety
- Use type hints with `numpy.typing` for array types
- Run `mypy src/ --strict` before commits
- Use NumPy-style docstrings for all functions

### 4. Testing Requirements
**Before ANY commit**, ensure:
- `pytest tests/ -v` passes (100%)
- `mypy src/ --strict` passes
- `flake8 src/ --max-line-length=100` passes
- `python scripts/verify_reproducibility.py` passes

If **any** validation fails: **STOP** → Fix → Then proceed.

## Known Technical Debt

### Priority 1: NetworkEnvironment Class (network.py:20)
- **Issue**: 330-line god object with multiple responsibilities
- **Contains**: Graph topology, state management, action execution, reward calculation, metrics tracking
- **Target refactoring**: Extract GraphTopology, NodeStateManager, ActionExecutor components
- **Skills**: Use `.claude/skills/refactoring/workflows/extract.md` + `.claude/skills/python-scientific/SKILL.md`

### Priority 2: run_corrected_experiment() (src/acp_corrected_final.py)
- **Issue**: 186-line monolithic orchestration function
- **Target**: Focused orchestration components with clear configuration patterns

### Priority 3: Agent Decision Logic
- **Issue**: Performance bottleneck in instance-based learning
- **Target**: Vectorized batch processing using NumPy operations

## Special Files and Entry Points

### Main Entry Points
- `src/acp_fully_configurable.py` - **Primary CLI** for running simulations (actively maintained)
- `src/acp_corrected_final.py` - Reference implementation (stable, do not modify)
- `acp_parallel_power_analysis.py` - Statistical power analysis engine (root level)

### Configuration Files
- `.clinerules` - Instructions for Cline AI assistant (read for context)
- `CONTEXT.md` - Operational context and project state
- `.pre-commit-config.yaml` - Comprehensive pre-commit hooks including reproducibility checks

### Claude Code Playbook
This project uses Claude Code Playbook v4.0.0:
- `.claude/skills/README.md` - Navigation hub for AI-assisted development workflows
- `.claude/skills/python-scientific/SKILL.md` - NumPy patterns, vectorization, profiling
- `.claude/skills/refactoring/SKILL.md` - Code organization workflows
- `.claude/skills/refactoring/workflows/` - Executable workflows (triage, extract, qnew, catchup)

**Session Management Protocol**: Every 5-7 prompts run `/cost`, `/clear`, then `view .claude/skills/refactoring/workflows/catchup.md`

## Development Workflow

### Starting a New Feature
1. Read `CONTEXT.md` for current project state
2. Identify affected modules in `src/acp_simulation/`
3. Write tests in `tests/` following existing patterns
4. Implement changes maintaining reproducibility constraints
5. Run full validation suite (pytest, mypy, flake8, reproducibility)
6. Use pre-commit hooks or run `pre-commit run --all-files`

### Refactoring Large Components
1. Use `.claude/skills/refactoring/workflows/triage.md` to analyze technical debt
2. Use `.claude/skills/refactoring/workflows/extract.md` for component extraction
3. Maintain 100% test pass rate throughout (never break tests)
4. Verify reproducibility after each change
5. Add type hints and NumPy-style docstrings

### Running Experiments
- Prefer `acp_fully_configurable.py` for new experiments (supports CLI configuration)
- Use `parameter_sweep.py` for sensitivity analysis
- All experiment results must be reproducible with same seed
- Report Cohen's d and p-values for performance comparisons

### Using Enterprise Network Topologies (NEW -  Conference)
```python
from src.acp_simulation.environment.network_enhanced import EnhancedNetworkEnvironment

# Hub-and-spoke (corporate server-client architecture)
env_hub = EnhancedNetworkEnvironment(
    num_nodes=50,
    topology_type='hub_spoke',
    vulnerability_distribution='gradient'  # Hubs secure, periphery vulnerable
)

# Hierarchical (security zones: DMZ, internal, endpoints)
env_hier = EnhancedNetworkEnvironment(
    num_nodes=50,
    topology_type='hierarchical',
    vulnerability_distribution='gradient'  # Outer layers vulnerable
)

# Get topology analysis
report = env_hub.get_topology_report()
print(f"Clustering: {report['metrics']['clustering_coefficient']:.3f}")
print(f"Hubs: {report['hub_count']}, Peripheral: {report['peripheral_count']}")
```

## Important Notes

- **Windows Development**: Project includes PowerShell scripts (`PUSH_FROM_WINDOWS.ps1`, `commit-playbook.ps1`) for Windows Git workflows
- **Network Topologies** (Updated Dec 2025):
  - **Erdős-Rényi**: Random baseline (legacy default)
  - **Barabási-Albert**: Scale-free networks
  - **Hub-and-Spoke**: Corporate server-client architectures (NEW - Dec 2025)
  - **Hierarchical**: Security zones - DMZ/internal/endpoints (NEW - Dec 2025)
  - Use `src/acp_simulation/environment/topology_generators.py` for custom topologies
- **ACTS Integration**: Combinatorial testing in `src/acp_simulation/integration/acts/`
  - Enhanced parameter space: `conference_parameters.py` includes topology types
  - 34,560 exhaustive combinations → ~200 tests (172.8x reduction)
- ** Conference Validation**: Implementations support the 2026  Kongress abstract on optimistic cognitive modeling (Dec 2025)
- **Legacy Files**: Files in root `src/` (non-package) are legacy; prefer package structure under `src/acp_simulation/`
- **Documentation**: Extensive planning docs exist (ACTS_INTEGRATION_PLAN.md, REFACTORING_PLAN.md) - consult before major changes
