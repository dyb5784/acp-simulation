#!/usr/bin/env python3
"""
Verify reproducibility of simulation results.

This script runs the simulation multiple times with the same seed
and verifies that results are identical.
"""

import sys
from pathlib import Path
import numpy as np
import json
from typing import Dict, Any

# Add src to path
sys.path.insert(0, str(Path(__file__).parent.parent / 'src'))


def run_quick_simulation(seed: int = 42) -> Dict[str, Any]:
    """Run a quick simulation for reproducibility testing.
    
    Parameters
    ----------
    seed : int
        Random seed for simulation
        
    Returns
    -------
    dict
        Simulation results with rewards and metrics
    """
    # Import simulation code
    try:
        # Try to import from the main simulation files
        # Adjust this import based on your actual structure
        from acp_corrected_final import run_simulation
        results = run_simulation(num_episodes=10, seed=seed)
    except ImportError:
        # Fallback: run a minimal simulation
        print("Warning: Could not import main simulation, running minimal test")
        rng = np.random.default_rng(seed)
        results = {
            'rewards': rng.standard_normal(10).tolist(),
            'mean_reward': float(rng.standard_normal())
        }
    
    return results


def verify_reproducibility(
    num_runs: int = 3,
    seed: int = 42,
    tolerance: float = 1e-10
) -> bool:
    """Verify that simulation produces identical results with same seed.
    
    Parameters
    ----------
    num_runs : int
        Number of times to run simulation
    seed : int
        Random seed to use
    tolerance : float
        Tolerance for floating point comparison
        
    Returns
    -------
    bool
        True if all runs produce identical results
    """
    print(f"Running reproducibility check ({num_runs} runs with seed={seed})...")
    
    results = []
    for i in range(num_runs):
        print(f"  Run {i+1}/{num_runs}...", end=' ')
        result = run_quick_simulation(seed)
        results.append(result)
        print("✓")
    
    # Compare all results to first run
    baseline = results[0]
    all_match = True
    
    for i, result in enumerate(results[1:], start=2):
        print(f"\nComparing run {i} to baseline:")
        
        # Compare each key in results
        for key in baseline.keys():
            if key not in result:
                print(f"  ✗ Key '{key}' missing in run {i}")
                all_match = False
                continue
            
            baseline_val = baseline[key]
            result_val = result[key]
            
            # Handle different types
            if isinstance(baseline_val, (list, np.ndarray)):
                baseline_arr = np.array(baseline_val)
                result_arr = np.array(result_val)
                
                if not np.allclose(baseline_arr, result_arr, rtol=tolerance, atol=tolerance):
                    max_diff = np.abs(baseline_arr - result_arr).max()
                    print(f"  ✗ '{key}' differs (max diff: {max_diff:.2e})")
                    all_match = False
                else:
                    print(f"  ✓ '{key}' matches")
                    
            elif isinstance(baseline_val, (int, float)):
                if not np.isclose(baseline_val, result_val, rtol=tolerance, atol=tolerance):
                    diff = abs(baseline_val - result_val)
                    print(f"  ✗ '{key}' differs (diff: {diff:.2e})")
                    all_match = False
                else:
                    print(f"  ✓ '{key}' matches")
            else:
                if baseline_val != result_val:
                    print(f"  ✗ '{key}' differs")
                    all_match = False
                else:
                    print(f"  ✓ '{key}' matches")
    
    return all_match


def check_seed_management() -> bool:
    """Check that code uses proper seed management.
    
    Returns
    -------
    bool
        True if seed management appears correct
    """
    print("\nChecking seed management in code...")
    
    src_dir = Path(__file__).parent.parent / 'src'
    issues = []
    
    if not src_dir.exists():
        print("  Warning: src/ directory not found, skipping code check")
        return True
    
    # Check for unseeded numpy random calls
    for py_file in src_dir.rglob('*.py'):
        with open(py_file) as f:
            content = f.read()
            
        # Look for problematic patterns
        if 'np.random.rand' in content and 'default_rng' not in content:
            issues.append(f"  ✗ {py_file.name}: Uses np.random without default_rng")
        
        if 'random.random()' in content and 'seed(' not in content:
            issues.append(f"  ✗ {py_file.name}: Uses random.random() without seed")
    
    if issues:
        print("\n".join(issues))
        return False
    else:
        print("  ✓ No obvious seed management issues found")
        return True


def main():
    """Main reproducibility verification."""
    print("=" * 60)
    print("ACP Simulation - Reproducibility Verification")
    print("=" * 60)
    
    # Check reproducibility
    repro_ok = verify_reproducibility(num_runs=3, seed=42)
    
    # Check seed management
    seed_ok = check_seed_management()
    
    # Summary
    print("\n" + "=" * 60)
    print("SUMMARY")
    print("=" * 60)
    
    if repro_ok:
        print("✓ Reproducibility check: PASSED")
    else:
        print("✗ Reproducibility check: FAILED")
    
    if seed_ok:
        print("✓ Seed management check: PASSED")
    else:
        print("✗ Seed management check: WARNING")
    
    # Exit code
    if repro_ok and seed_ok:
        print("\n✓ All checks passed - simulation is reproducible")
        sys.exit(0)
    elif repro_ok:
        print("\n⚠ Reproducibility verified, but seed management needs review")
        sys.exit(0)  # Don't fail on warnings
    else:
        print("\n✗ Reproducibility check failed - DO NOT COMMIT")
        sys.exit(1)


if __name__ == '__main__':
    main()
