# Zero-Latency Robustness Test - Implementation Plan

## Overview
This document provides the complete implementation plan for testing ACP's robustness when the Attacker has no processing delay (zero latency). The implementation involves refactoring the NetworkEnvironment to accept configurable latency_window parameters and creating a comprehensive sweep from [0.0, 0.0] to [1.0, 2.0].

## Architectural Changes

### 1. CLI Parameter Addition (acp_fully_configurable.py)

**Location**: Lines 585-599
**Change**: Add latency window parameters to argument parser

```diff
:start_line:585
-------
    # Episode configuration
    parser.add_argument('--num-episodes', type=int, default=1000,
                       help='Total number of episodes (default: 1000)')
    parser.add_argument('--cores', type=int, default=None,
                       help='Number of CPU cores (default: auto-detect)')
    
    # ACP configuration
    parser.add_argument('--acp-strength', type=float, default=0.65,
                       help='ACP deception probability 0.0-1.0 (default: 0.65)')
    
    # Network configuration
    parser.add_argument('--num-nodes', type=int, default=50,
                       help='Number of nodes in network (default: 50)')
    parser.add_argument('--connectivity', type=float, default=0.6,
                       help='Network connectivity 0.0-1.0 (default: 0.6)')
    
    # Latency configuration
    parser.add_argument('--latency-window-min', type=float, default=0.3,
                       help='Minimum cognitive latency for attacker (default: 0.3)')
    parser.add_argument('--latency-window-max', type=float, default=0.8,
                       help='Maximum cognitive latency for attacker (default: 0.8)')
```

### 2. Parameter Validation (acp_fully_configurable.py)

**Location**: Lines 630-638
**Change**: Add validation for latency window parameters

```diff
:start_line:630
-------
    # Validate parameters
    if not 0.0 <= args.acp_strength <= 1.0:
        parser.error("--acp-strength must be between 0.0 and 1.0")
    if not 0.0 <= args.connectivity <= 1.0:
        parser.error("--connectivity must be between 0.0 and 1.0")
    if not 0.0 <= args.latency_window_min <= 5.0:
        parser.error("--latency-window-min must be between 0.0 and 5.0")
    if not 0.0 <= args.latency_window_max <= 5.0:
        parser.error("--latency-window-max must be between 0.0 and 5.0")
    if args.latency_window_min > args.latency_window_max:
        parser.error("--latency-window-min must be <= --latency-window-max")
    if args.confidence_level not in [0.90, 0.95, 0.99]:
        parser.error("--confidence-level must be 0.90, 0.95, or 0.99")
    if args.num_nodes < 10:
```

### 3. Configuration Dictionary (acp_fully_configurable.py)

**Location**: Lines 640-653
**Change**: Add latency_window to config dictionary

```diff
:start_line:640
-------
    # Build configuration
    config = {
        'num_episodes': args.num_episodes,
        'n_cores': args.cores,
        'acp_strength': args.acp_strength,
        'num_nodes': args.num_nodes,
        'connectivity': args.connectivity,
        'latency_window': (args.latency_window_min, args.latency_window_max),
        'confidence_level': args.confidence_level,
        'bootstrap_samples': args.bootstrap_samples,
        'learning_rate': args.learning_rate,
        'decay_rate': args.decay_rate,
        'noise': args.noise,
        'vulnerability_distribution': args.vulnerability_distribution
    }
```

### 4. Environment Initialization (acp_fully_configurable.py)

**Location**: Lines 270-276
**Change**: Pass latency_window to ConfigurableNetworkEnvironment

```diff
:start_line:270
-------
    # Create environment with config
    env = ConfigurableNetworkEnvironment(
        num_nodes=config['num_nodes'],
        connectivity=config['connectivity'],
        vulnerability_distribution=config['vulnerability_distribution'],
        latency_window=config['latency_window']
    )
```

### 5. Sweep Parameter Support (parameter_sweep.py)

**Location**: Lines 85-88
**Change**: Add latency_window handling in sweep_single_parameter

```diff
:start_line:85
-------
            elif param_name == 'bootstrap_samples':
                cmd.append(f'--bootstrap-samples={value}')
            elif param_name == 'latency_window':
                # Handle tuple format (min, max)
                cmd.append(f'--latency-window-min={value[0]}')
                cmd.append(f'--latency-window-max={value[1]}')
```

### 6. Base Configuration Update (parameter_sweep.py)

**Location**: Lines 270-281
**Change**: Add latency_window to base config

```diff
:start_line:270
-------
    # Base configuration
    base_config = {
        'acp_strength': 0.65,
        'num_nodes': 50,
        'connectivity': 0.6,
        'latency_window': (0.3, 0.8),
        'learning_rate': 1.0,
        'decay_rate': 0.8,
        'noise': 0.1,
        'confidence_level': 0.95,
        'bootstrap_samples': 10000,
        'vulnerability_distribution': 'uniform'
    }
```

## Test Configuration Files

### Reproducibility Test Script (test_latency_reproducibility.py)

```python
"""
Reproducibility test for latency window modifications.
Tests seed 42 with zero-latency configuration.
"""

import subprocess
import sys
import json

def test_reproducibility():
    """Run reproducibility check with seed 42"""
    
    # Test configuration - zero latency
    config = {
        'num_episodes': 100,
        'acp_strength': 0.65,
        'num_nodes': 50,
        'connectivity': 0.6,
        'latency_window': (0.0, 0.0),  # ZERO LATENCY - critical test
        'learning_rate': 1.0,
        'decay_rate': 0.8,
        'noise': 0.1,
        'confidence_level': 0.95,
        'bootstrap_samples': 1000,
        'vulnerability_distribution': 'uniform'
    }
    
    # Save config
    with open('latency_test_config.json', 'w') as f:
        json.dump(config, f, indent=2)
    
    # Run with seed 42
    cmd = [
        'python', 'src/acp_fully_configurable.py',
        '--num-episodes=100',
        '--latency-window-min=0.0',
        '--latency-window-max=0.0',
        '--output-prefix=latency_reproducibility_test'
    ]
    
    print("Running reproducibility test with seed 42...")
    print(f"Command: {' '.join(cmd)}")
    
    result = subprocess.run(cmd, capture_output=True, text=True)
    
    if result.returncode == 0:
        print("✅ Reproducibility test PASSED")
        print("Output:", result.stdout[-500:])  # Last 500 chars
        return True
    else:
        print("❌ Reproducibility test FAILED")
        print("Error:", result.stderr)
        return False

if __name__ == "__main__":
    success = test_reproducibility()
    sys.exit(0 if success else 1)
```

### Latency Sweep Configuration (latency_sweep_config.py)

```python
"""
Zero-Latency Robustness Test Configuration
Tests ACP performance across latency ranges from [0.0, 0.0] to [1.0, 2.0]
"""

LATENCY_SWEEP_VALUES = [
    (0.0, 0.0),   # Zero latency - critical test case
    (0.1, 0.2),   # Very low latency
    (0.3, 0.8),   # Default/current range
    (0.5, 1.0),   # Medium latency
    (1.0, 2.0)    # High latency
]

BASE_CONFIG = {
    'acp_strength': 0.65,
    'num_nodes': 50,
    'connectivity': 0.6,
    'learning_rate': 1.0,
    'decay_rate': 0.8,
    'noise': 0.1,
    'confidence_level': 0.95,
    'bootstrap_samples': 10000,
    'vulnerability_distribution': 'uniform',
    'num_episodes': 2000,
    'n_cores': 8
}
```

## Execution Plan

### Phase 1: Implementation
1. Apply all diffs to [`acp_fully_configurable.py`](src/acp_fully_configurable.py)
2. Apply diffs to [`parameter_sweep.py`](src/parameter_sweep.py)
3. Create test scripts

### Phase 2: Verification
1. Run reproducibility test: `python test_latency_reproducibility.py`
2. Verify seed 42 produces consistent results
3. Confirm zero-latency configuration works

### Phase 3: Sweep Execution
1. Run latency sweep: `python src/parameter_sweep.py latency_window`
2. Analyze results for ACP degradation at zero latency
3. Generate statistical report with Cohen's d and p-values

## Expected Results

### Hypothesis
ACP should show **significant performance degradation** at zero latency because:
- No cognitive processing delay means no "latency arbitrage" opportunity
- Defender cannot deploy deception during attacker's processing window
- ACP's core mechanism (cognitive latency exploitation) is neutralized

### Success Criteria
- ✅ Reproducibility test passes with seed 42
- ✅ Zero-latency configuration runs without errors
- ✅ Statistical analysis shows ACP degradation at (0.0, 0.0)
- ✅ Cohen's d indicates large effect size difference between latency ranges
- ✅ p-values < 0.05 for statistical significance

## Statistical Validation Requirements

Per CONTEXT.md constraints:
- **Cohen's d**: Must be reported for all comparisons
- **p-values**: Must be < 0.05 for significance claims
- **Power**: Must maintain > 80% statistical power
- **Reproducibility**: All results must be seed-dependent, no global random state

## Implementation Checklist

- [ ] All diffs applied to source files
- [ ] Reproducibility test script created
- [ ] Sweep configuration defined
- [ ] CLI parameters validated
- [ ] Environment initialization updated
- [ ] Parameter sweep integration complete
- [ ] Documentation updated

## Next Steps

1. Switch to Code mode to implement the diffs
2. Run reproducibility test
3. Execute full latency sweep
4. Analyze results and generate report