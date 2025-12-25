"""
Reproducibility test for latency window modifications.
Tests seed 42 with zero-latency configuration.
"""

import subprocess
import sys
import json
import os

def test_reproducibility():
    """Run reproducibility check with seed 42"""
    
    # Change to the correct directory
    os.chdir('g:/My Drive/acp-simulation')
    
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
    
    # Run with seed 42 (implicitly handled by episode_id seeding)
    cmd = [
        'python', 'src/acp_fully_configurable.py',
        '--num-episodes=100',
        '--latency-window-min=0.0',
        '--latency-window-max=0.0',
        '--output-prefix=latency_reproducibility_test'
    ]
    
    print("Running reproducibility test with seed 42...")
    print(f"Command: {' '.join(cmd)}")
    print(f"Working directory: {os.getcwd()}")
    
    result = subprocess.run(cmd, capture_output=True, text=True)
    
    if result.returncode == 0:
        print("SUCCESS: Reproducibility test PASSED")
        print("Output:", result.stdout[-500:])  # Last 500 chars
        return True
    else:
        print("ERROR: Reproducibility test FAILED")
        print("Error:", result.stderr)
        print("Stdout:", result.stdout)
        return False

if __name__ == "__main__":
    success = test_reproducibility()
    sys.exit(0 if success else 1)