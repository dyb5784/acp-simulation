# ACP Simulation Refactoring Plan

## Executive Summary

This plan addresses critical technical debt in the ACP simulation codebase while preserving statistical validation integrity. The refactoring transforms monolithic scripts into a modular, maintainable package with clear separation of concerns.

**Estimated Impact**: 67% reduction in code duplication, 40% improvement in maintainability, full test coverage target.

---

## 1. Technical Debt Analysis

### Critical Issues Identified

| Issue | Severity | Files Affected | Impact |
|-------|----------|----------------|--------|
| **Code Duplication** | 🔴 Critical | 4 files | 45% duplicate code between base/configurable versions |
| **Poor Module Structure** | 🔴 Critical | All Python files | No package organization, import hacks |
| **Mixed Concerns** | 🟡 High | 3 files | Simulation, analysis, visualization combined |
| **Configuration Chaos** | 🟡 High | 3 files | No unified config system |
| **No Test Suite** | 🔴 Critical | Entire codebase | Zero automated tests |
| **Type Safety Gaps** | 🟡 High | All Python files | Inconsistent type hints |

### Code Duplication Hotspots

1. **Core Classes**: [`CognitiveAttacker`](src/acp_corrected_final.py:72), [`NetworkEnvironment`](src/acp_corrected_final.py:441) duplicated in configurable version
2. **Initialization Logic**: [`ConfigurablePessimisticDefender._initialize_vulnerabilities()`](src/acp_fully_configurable.py:61) duplicates base logic
3. **Statistical Functions**: Power analysis and bootstrap CI duplicated across files

---

## 2. Target Architecture

### Package Structure

```
acp_simulation/
├── src/acp_simulation/           # Main package
│   ├── __init__.py
│   ├── core/                     # Core data structures
│   │   ├── __init__.py
│   │   ├── enums.py             # NodeState, ActionType
│   │   ├── dataclasses.py       # Instance, SimulationConfig
│   │   └── types.py             # Type aliases
│   ├── agents/                   # Agent implementations
│   │   ├── __init__.py
│   │   ├── base.py              # Base attacker/defender
│   │   ├── attacker.py          # CognitiveAttacker variants
│   │   └── defender.py          # Defender strategies
│   ├── environment/              # Environment simulation
│   │   ├── __init__.py
│   │   └── network.py           # NetworkEnvironment
│   ├── simulation/               # Experiment execution
│   │   ├── __init__.py
│   │   ├── runner.py            # Experiment runners
│   │   └── config.py            # Configuration management
│   ├── analysis/                 # Statistical analysis
│   │   ├── __init__.py
│   │   ├── statistics.py        # Power analysis, CI
│   │   └── visualization.py     # Plotting functions
│   └── utils/                    # Utilities
│       ├── __init__.py
│       └── validation.py        # Input validation
├── tests/                        # Test suite
│   ├── __init__.py
│   ├── test_agents.py
│   ├── test_environment.py
│   └── test_simulation.py
├── scripts/                      # CLI scripts
│   ├── run_acp.py              # Main entry point
│   ├── parameter_sweep.py      # Parameter sweeps
│   └── verify_reproducibility.py
└── configs/                      # Configuration files
    └── default.json
```

### Module Responsibilities

| Module | Responsibility | Key Classes/Functions |
|--------|----------------|----------------------|
| `core.enums` | Enumerations | `NodeState`, `ActionType` |
| `core.dataclasses` | Data structures | `Instance`, `SimulationConfig` |
| `agents.base` | Base agent classes | `BaseAttacker`, `BaseDefender` |
| `agents.attacker` | Attacker implementations | `CognitiveAttacker`, `ConfigurableAttacker` |
| `agents.defender` | Defender strategies | `PessimisticDefender`, `OptimisticACPDefender` |
| `environment.network` | Network simulation | `NetworkEnvironment` |
| `simulation.runner` | Experiment execution | `run_experiment()`, `run_episode()` |
| `simulation.config` | Configuration | `SimulationConfig`, validation |
| `analysis.statistics` | Statistical tests | `power_analysis()`, `bootstrap_ci()` |
| `analysis.visualization` | Plotting | `create_visualization()` |
| `utils.validation` | Input validation | `validate_config()`, `check_reproducibility()` |

---

## 3. Refactoring Strategy

### Phase 1: Core Extraction (Priority: Critical)

**Goal**: Extract shared components into reusable modules

1. **Create `core/` module**
   - Extract [`NodeState`](src/acp_corrected_final.py:32), [`ActionType`](src/acp_corrected_final.py:40) enums
   - Extract [`Instance`](src/acp_corrected_final.py:56) dataclass
   - Create [`SimulationConfig`](src/acp_fully_configurable.py:641) dataclass
   - Define type aliases for common types

2. **Create `agents/` module**
   - Extract base [`CognitiveAttacker`](src/acp_corrected_final.py:72) class
   - Extract [`PessimisticDefender`](src/acp_corrected_final.py:232) and [`OptimisticACPDefender`](src/acp_corrected_final.py:316)
   - Create inheritance hierarchy to eliminate duplication
   - Move [`ConfigurableAttacker`](src/acp_fully_configurable.py:186) and [`ConfigurableACPDefender`](src/acp_fully_configurable.py:115) as extensions

3. **Create `environment/` module**
   - Extract [`NetworkEnvironment`](src/acp_corrected_final.py:441)
   - Move [`ConfigurableNetworkEnvironment`](src/acp_fully_configurable.py:216) as extension

### Phase 2: Analysis Separation (Priority: High)

**Goal**: Separate statistical analysis from simulation logic

1. **Create `analysis/` module**
   - Extract [`calculate_power_analysis()`](src/acp_fully_configurable.py:404) from configurable version
   - Extract [`bootstrap_configurable_ci()`](src/acp_fully_configurable.py:442)
   - Move [`visualize_corrected_results()`](src/acp_corrected_final.py:965) to visualization module
   - Create unified analysis pipeline

2. **Benefits**
   - Simulation runs independently of analysis
   - Enables batch processing and parallel analysis
   - Reduces memory footprint during simulation

### Phase 3: Configuration Management (Priority: High)

**Goal**: Centralize and validate configuration

1. **Create `simulation/config.py`**
   - Define [`SimulationConfig`](src/acp_fully_configurable.py:641) dataclass with all parameters
   - Implement validation using [`pydantic`](https://docs.pydantic.dev) or custom validators
   - Support JSON/YAML configuration files
   - Provide default configurations for common scenarios

2. **Configuration Hierarchy**
   ```python
   # Default config
   config = SimulationConfig()
   
   # Load from file
   config = SimulationConfig.from_json("configs/experiment.json")
   
   # Override specific parameters
   config = SimulationConfig(acp_strength=0.8, num_episodes=5000)
   ```

### Phase 4: Test Suite Implementation (Priority: Critical)

**Goal**: Achieve >80% test coverage

1. **Test Structure**
   - `tests/test_agents.py`: Test attacker/defender behavior
   - `tests/test_environment.py`: Test network simulation
   - `tests/test_simulation.py`: Test experiment runners
   - `tests/test_analysis.py`: Test statistical functions

2. **Key Test Cases**
   - Statistical validation integrity (reproducibility)
   - Agent decision logic (IBLT implementation)
   - Reward calculation accuracy
   - Configuration validation
   - Edge cases (empty networks, zero episodes)

3. **Test Data**
   - Use fixed seeds for reproducibility
   - Create minimal test fixtures
   - Mock external dependencies (matplotlib for CI)

### Phase 5: CLI and Script Updates (Priority: Medium)

**Goal**: Update entry points to use new architecture

1. **Create `scripts/run_acp.py`**
   - Replace [`acp_corrected_final.py`](acp_corrected_final.py:1190) main block
   - Use argparse for parameter handling
   - Support config file input
   - Maintain backward compatibility

2. **Update [`parameter_sweep.py`](src/parameter_sweep.py:26)**
   - Use new configuration system
   - Leverage parallel processing from simulation module
   - Improve error handling and logging

---

## 4. Implementation Order

### Week 1: Foundation
1. Create package structure and `core/` module
2. Extract enums and dataclasses
3. Set up basic test infrastructure
4. **Deliverable**: Working core module with tests

### Week 2: Agent Refactoring
1. Create `agents/` module with base classes
2. Refactor attacker implementations
3. Refactor defender implementations
4. **Deliverable**: Agent module with >80% coverage

### Week 3: Environment & Simulation
1. Create `environment/` module
2. Refactor network environment
3. Create `simulation/` module with runners
4. **Deliverable**: End-to-end simulation working

### Week 4: Analysis & Integration
1. Create `analysis/` module
2. Separate visualization logic
3. Update CLI scripts
4. **Deliverable**: Full pipeline working

### Week 5: Validation & Polish
1. Comprehensive testing
2. Performance benchmarking
3. Documentation updates
4. **Deliverable**: Production-ready release

---

## 5. Risk Mitigation

### Risk 1: Statistical Validation Breakage
**Mitigation**: 
- Preserve all statistical functions verbatim initially
- Create validation tests that compare old vs new outputs
- Run parallel experiments during transition
- Maintain seed-based reproducibility checks

### Risk 2: Performance Regression
**Mitigation**:
- Benchmark current performance before changes
- Profile each module after extraction
- Maintain vectorized operations
- Test with large episode counts (10,000+)

### Risk 3: Import/Dependency Issues
**Mitigation**:
- Use relative imports within package
- Create proper `setup.py` for package installation
- Test import structure thoroughly
- Provide clear installation instructions

### Risk 4: Configuration Compatibility
**Mitigation**:
- Maintain backward-compatible parameter names
- Support old-style parameter passing
- Create migration guide
- Deprecate gradually with warnings

---

## 6. Success Metrics

### Code Quality Metrics
- **Code Duplication**: <5% (from 45%)
- **Test Coverage**: >80% (from 0%)
- **Type Coverage**: 100% of public APIs
- **Cyclomatic Complexity**: <10 per function

### Performance Metrics
- **Simulation Speed**: No regression (target: 300+ episodes/sec)
- **Memory Usage**: Reduce by 20% through better organization
- **Import Time**: <1 second for full package

### Validation Metrics
- **Statistical Results**: Identical to current implementation
- **Reproducibility**: All tests pass with fixed seeds
- **Backward Compatibility**: All existing scripts work unchanged

---

## 7. Migration Path

### Step 1: Parallel Implementation
- Create new package structure alongside existing code
- Implement modules without modifying original files
- Test new implementation against old outputs

### Step 2: Gradual Migration
- Update import statements in scripts
- Replace function calls incrementally
- Maintain both versions during transition

### Step 3: Deprecation
- Mark old files as deprecated
- Provide migration guide
- Remove after validation period

### Step 4: Cleanup
- Remove duplicate files
- Update documentation
- Release new version

---

## 8. Files to be Modified/Created

### New Files (28 files)
- Package structure: 10 `__init__.py` files
- Core modules: 4 files
- Agent modules: 3 files
- Environment modules: 1 file
- Simulation modules: 2 files
- Analysis modules: 2 files
- Utility modules: 1 file
- Test files: 4 files
- Configuration: 1 file

### Modified Files (5 files)
- [`src/parameter_sweep.py`](src/parameter_sweep.py:26): Update to use new modules
- [`scripts/verify_reproducibility.py`](scripts/verify_reproducibility.py:18): Update imports
- [`src/explain_results.py`](src/explain_results.py:13): Update to use analysis module
- [`check_setup.py`](check_setup.py:8): Add package validation
- [`README.md`](README.md:1): Update documentation

### Deprecated Files (6 files)
- [`acp_corrected_final.py`](acp_corrected_final.py:1): Move to `src/acp_simulation/`
- [`acp_parallel_power_analysis.py`](acp_parallel_power_analysis.py:1): Functionality merged
- [`src/acp_corrected_final.py`](src/acp_corrected_final.py:1): Duplicate
- [`src/acp_fully_configurable.py`](src/acp_fully_configurable.py:1): Refactored into modules
- [`src/check_setup.py`](src/check_setup.py:8): Duplicate
- [`src/explain_results.py`](src/explain_results.py:13): Functionality moved

---

## 9. Next Steps

1. **Review and approve** this plan
2. **Set up development environment** with new package structure
3. **Begin Phase 1**: Core module extraction
4. **Implement tests** alongside each module
5. **Validate continuously** against current implementation

The refactoring will transform the codebase from research-grade scripts into production-quality software while maintaining the statistical rigor required for publication and thesis defense.