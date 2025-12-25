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
