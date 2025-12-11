# Research Validation Workflow

This workflow ensures statistical rigor and reproducibility for research claims.

## When to Use

Use this workflow when:
- Making claims about ACP effectiveness
- Comparing defense strategies statistically
- Preparing results for publication or thesis defense
- Validating new parameter configurations

## Workflow Steps

### 1. Define Hypothesis

**Before running experiments**, clearly state:
- **Null hypothesis (H₀)**: No difference between conditions
- **Alternative hypothesis (H₁)**: ACP shows improvement
- **Effect size expectation**: Cohen's d > 0.8 (large effect)
- **Statistical power target**: ≥ 80%
- **Significance level**: α = 0.05

**Example:**
```python
# Document in your experiment script
"""
Hypothesis Test: ACP vs Traditional Defense

H₀: μ_ACP = μ_Traditional (no difference in mean rewards)
H₁: μ_ACP > μ_Traditional (ACP provides higher rewards)

Expected effect size: d > 0.8 (large effect)
Target power: 80%
Alpha level: 0.05
Minimum sample size: 30 per group (from power analysis)
"""
```

### 2. Determine Sample Size

Use power analysis to determine required sample size:

```python
from scipy.stats import ttest_ind_from_stats
import numpy as np

def compute_required_sample_size(
    expected_effect_size: float = 0.8,
    alpha: float = 0.05,
    power: float = 0.80
) -> int:
    """Compute required sample size for two-sample t-test.
    
    Parameters
    ----------
    expected_effect_size : float
        Expected Cohen's d
    alpha : float
        Significance level
    power : float
        Desired statistical power
        
    Returns
    -------
    int
        Required sample size per group
    """
    from scipy.stats import norm
    
    z_alpha = norm.ppf(1 - alpha/2)
    z_beta = norm.ppf(power)
    
    n = 2 * ((z_alpha + z_beta) / expected_effect_size) ** 2
    
    return int(np.ceil(n))

# Example usage
n_required = compute_required_sample_size(
    expected_effect_size=0.8,
    alpha=0.05,
    power=0.80
)
print(f"Required sample size per group: {n_required}")
```

### 3. Run Experiment with Multiple Seeds

**Critical**: Run with multiple independent seeds to verify robustness:

```python
from dataclasses import dataclass
import numpy as np

@dataclass
class ExperimentResult:
    """Results from single experiment run."""
    seed: int
    mean_reward: float
    std_reward: float
    num_episodes: int

def run_multi_seed_experiment(
    base_seed: int = 42,
    num_seeds: int = 5,
    episodes_per_seed: int = 100
) -> list[ExperimentResult]:
    """Run experiment with multiple seeds.
    
    Parameters
    ----------
    base_seed : int
        Base seed for reproducibility
    num_seeds : int
        Number of different seeds to try
    episodes_per_seed : int
        Episodes per seed
        
    Returns
    -------
    list[ExperimentResult]
        Results for each seed
    """
    results = []
    
    for i in range(num_seeds):
        seed = base_seed + i * 1000  # Ensure seeds well-separated
        
        # Run experiment with this seed
        rewards = run_simulation(
            num_episodes=episodes_per_seed,
            seed=seed
        )
        
        result = ExperimentResult(
            seed=seed,
            mean_reward=float(np.mean(rewards)),
            std_reward=float(np.std(rewards, ddof=1)),
            num_episodes=episodes_per_seed
        )
        results.append(result)
    
    return results
```

### 4. Compute Effect Size

Always report Cohen's d for effect size:

```python
def compute_cohens_d(
    mean1: float,
    std1: float,
    n1: int,
    mean2: float,
    std2: float,
    n2: int
) -> float:
    """Compute Cohen's d effect size.
    
    Parameters
    ----------
    mean1, mean2 : float
        Sample means
    std1, std2 : float
        Sample standard deviations
    n1, n2 : int
        Sample sizes
        
    Returns
    -------
    float
        Cohen's d effect size
    """
    # Pooled standard deviation
    pooled_std = np.sqrt(
        ((n1 - 1) * std1**2 + (n2 - 1) * std2**2) / (n1 + n2 - 2)
    )
    
    return (mean1 - mean2) / pooled_std

# Interpretation guide
def interpret_effect_size(d: float) -> str:
    """Interpret Cohen's d effect size."""
    abs_d = abs(d)
    if abs_d < 0.2:
        return "negligible"
    elif abs_d < 0.5:
        return "small"
    elif abs_d < 0.8:
        return "medium"
    else:
        return "large"
```

### 5. Bootstrap Confidence Intervals

Use bootstrap for non-parametric confidence intervals:

```python
def bootstrap_ci(
    data: np.ndarray,
    statistic: callable = np.mean,
    n_bootstrap: int = 10000,
    confidence_level: float = 0.95
) -> tuple[float, float, float]:
    """Compute bootstrap confidence interval.
    
    Parameters
    ----------
    data : np.ndarray
        Data to bootstrap
    statistic : callable
        Function to compute statistic
    n_bootstrap : int
        Number of bootstrap samples
    confidence_level : float
        Confidence level (e.g., 0.95 for 95% CI)
        
    Returns
    -------
    tuple[float, float, float]
        (point_estimate, lower_ci, upper_ci)
    """
    rng = np.random.default_rng(42)
    
    # Compute point estimate
    point_estimate = statistic(data)
    
    # Bootstrap
    bootstrap_stats = np.zeros(n_bootstrap)
    n = len(data)
    
    for i in range(n_bootstrap):
        sample = rng.choice(data, size=n, replace=True)
        bootstrap_stats[i] = statistic(sample)
    
    # Compute CI
    alpha = 1 - confidence_level
    lower = np.percentile(bootstrap_stats, 100 * alpha/2)
    upper = np.percentile(bootstrap_stats, 100 * (1 - alpha/2))
    
    return float(point_estimate), float(lower), float(upper)

# Example usage
mean_reward, ci_lower, ci_upper = bootstrap_ci(
    acp_rewards,
    statistic=np.mean,
    n_bootstrap=10000,
    confidence_level=0.95
)

print(f"Mean reward: {mean_reward:.2f} [95% CI: {ci_lower:.2f}, {ci_upper:.2f}]")
```

### 6. Verify Statistical Assumptions

Check assumptions before hypothesis testing:

```python
from scipy import stats

def check_normality(data: np.ndarray, alpha: float = 0.05) -> bool:
    """Check if data is approximately normal using Shapiro-Wilk test.
    
    Parameters
    ----------
    data : np.ndarray
        Data to test
    alpha : float
        Significance level
        
    Returns
    -------
    bool
        True if data appears normal
    """
    stat, p_value = stats.shapiro(data)
    is_normal = p_value > alpha
    
    print(f"Shapiro-Wilk test: W={stat:.4f}, p={p_value:.4f}")
    print(f"  → Data {'appears normal' if is_normal else 'not normal'} (α={alpha})")
    
    return is_normal

def check_equal_variance(
    data1: np.ndarray,
    data2: np.ndarray,
    alpha: float = 0.05
) -> bool:
    """Check if two samples have equal variance using Levene's test.
    
    Parameters
    ----------
    data1, data2 : np.ndarray
        Data samples
    alpha : float
        Significance level
        
    Returns
    -------
    bool
        True if variances appear equal
    """
    stat, p_value = stats.levene(data1, data2)
    equal_var = p_value > alpha
    
    print(f"Levene's test: W={stat:.4f}, p={p_value:.4f}")
    print(f"  → Variances {'appear equal' if equal_var else 'differ'} (α={alpha})")
    
    return equal_var

# Example usage
print("Checking statistical assumptions:")
print("\nNormality check:")
normal_acp = check_normality(acp_rewards)
normal_trad = check_normality(traditional_rewards)

print("\nEqual variance check:")
equal_var = check_equal_variance(acp_rewards, traditional_rewards)

# Choose appropriate test
if normal_acp and normal_trad and equal_var:
    print("\n→ Use standard t-test")
elif normal_acp and normal_trad:
    print("\n→ Use Welch's t-test (unequal variances)")
else:
    print("\n→ Use Mann-Whitney U test (non-parametric)")
```

### 7. Conduct Hypothesis Test

Perform appropriate statistical test:

```python
def conduct_hypothesis_test(
    acp_rewards: np.ndarray,
    traditional_rewards: np.ndarray,
    alpha: float = 0.05
) -> dict:
    """Conduct hypothesis test comparing ACP to traditional defense.
    
    Parameters
    ----------
    acp_rewards : np.ndarray
        Rewards from ACP defense
    traditional_rewards : np.ndarray
        Rewards from traditional defense
    alpha : float
        Significance level
        
    Returns
    -------
    dict
        Test results including p-value, effect size, power
    """
    # Check assumptions
    normal_acp = stats.shapiro(acp_rewards)[1] > alpha
    normal_trad = stats.shapiro(traditional_rewards)[1] > alpha
    equal_var = stats.levene(acp_rewards, traditional_rewards)[1] > alpha
    
    # Choose test
    if normal_acp and normal_trad:
        if equal_var:
            stat, p_value = stats.ttest_ind(acp_rewards, traditional_rewards)
            test_name = "Independent t-test"
        else:
            stat, p_value = stats.ttest_ind(acp_rewards, traditional_rewards, equal_var=False)
            test_name = "Welch's t-test"
    else:
        stat, p_value = stats.mannwhitneyu(acp_rewards, traditional_rewards, alternative='greater')
        test_name = "Mann-Whitney U test"
    
    # Compute effect size
    d = compute_cohens_d(
        np.mean(acp_rewards), np.std(acp_rewards, ddof=1), len(acp_rewards),
        np.mean(traditional_rewards), np.std(traditional_rewards, ddof=1), len(traditional_rewards)
    )
    
    # Compute observed power
    from statsmodels.stats.power import ttest_power
    power = ttest_power(
        effect_size=d,
        nobs=len(acp_rewards),
        alpha=alpha,
        alternative='larger'
    )
    
    return {
        'test_name': test_name,
        'statistic': float(stat),
        'p_value': float(p_value),
        'significant': p_value < alpha,
        'cohens_d': float(d),
        'effect_size_interpretation': interpret_effect_size(d),
        'statistical_power': float(power),
        'adequate_power': power >= 0.80
    }
```

### 8. Document Results

Create comprehensive results report:

```python
def generate_results_report(
    acp_rewards: np.ndarray,
    traditional_rewards: np.ndarray,
    config: dict,
    output_path: str = 'outputs/results_report.json'
) -> dict:
    """Generate comprehensive results report.
    
    Parameters
    ----------
    acp_rewards : np.ndarray
        Rewards from ACP defense
    traditional_rewards : np.ndarray
        Rewards from traditional defense
    config : dict
        Experiment configuration
    output_path : str
        Path to save report
        
    Returns
    -------
    dict
        Complete results report
    """
    import sys
    from datetime import datetime
    
    # Descriptive statistics
    acp_mean, acp_ci_low, acp_ci_high = bootstrap_ci(acp_rewards)
    trad_mean, trad_ci_low, trad_ci_high = bootstrap_ci(traditional_rewards)
    
    # Hypothesis test
    test_results = conduct_hypothesis_test(acp_rewards, traditional_rewards)
    
    # Build report
    report = {
        'metadata': {
            'timestamp': datetime.now().isoformat(),
            'python_version': sys.version,
            'numpy_version': np.__version__,
            'config': config
        },
        'descriptive_statistics': {
            'acp': {
                'n': len(acp_rewards),
                'mean': float(np.mean(acp_rewards)),
                'std': float(np.std(acp_rewards, ddof=1)),
                'ci_95': [acp_ci_low, acp_ci_high]
            },
            'traditional': {
                'n': len(traditional_rewards),
                'mean': float(np.mean(traditional_rewards)),
                'std': float(np.std(traditional_rewards, ddof=1)),
                'ci_95': [trad_ci_low, trad_ci_high]
            }
        },
        'hypothesis_test': test_results,
        'interpretation': {
            'conclusion': (
                f"ACP shows {test_results['effect_size_interpretation']} improvement "
                f"(d={test_results['cohens_d']:.3f}) over traditional defense. "
                f"This difference is statistically {'significant' if test_results['significant'] else 'not significant'} "
                f"(p={test_results['p_value']:.6f}) with {test_results['statistical_power']*100:.1f}% power."
            )
        }
    }
    
    # Save report
    import json
    with open(output_path, 'w') as f:
        json.dump(report, f, indent=2)
    
    print(f"Results report saved to: {output_path}")
    
    return report
```

## Quality Checklist

Before claiming results are publication-ready:

- [ ] **Sample size adequate**: Based on power analysis (n ≥ 30 per group)
- [ ] **Multiple seeds tested**: At least 3-5 independent seeds
- [ ] **Effect size reported**: Cohen's d with interpretation
- [ ] **Confidence intervals**: 95% CIs for all estimates
- [ ] **Statistical power**: ≥ 80% achieved
- [ ] **Assumptions checked**: Normality, equal variance
- [ ] **Appropriate test**: Based on assumption checks
- [ ] **Configuration saved**: JSON file with all parameters
- [ ] **Versions logged**: Python, NumPy, SciPy versions
- [ ] **Reproducible**: Same seed produces identical results
- [ ] **Git commit**: Results tied to specific code version

## Common Pitfalls

### ❌ Don't Do This
- Running single experiment and claiming results
- Cherry-picking best seed
- Not checking statistical assumptions
- Reporting only p-values without effect sizes
- Ignoring statistical power

### ✅ Do This
- Multiple independent seeds
- Report results from all seeds
- Check and document assumptions
- Always report effect sizes and CIs
- Verify adequate statistical power
- Document everything for reproducibility

## Example Complete Workflow

```python
# 1. Define experiment
config = {
    'num_seeds': 5,
    'episodes_per_seed': 100,
    'base_seed': 42,
    'expected_effect_size': 0.8,
    'alpha': 0.05,
    'target_power': 0.80
}

# 2. Determine sample size
n_required = compute_required_sample_size(
    expected_effect_size=config['expected_effect_size'],
    power=config['target_power']
)
print(f"Required sample size: {n_required} per group")

# 3. Run experiments
acp_results = run_multi_seed_experiment(
    base_seed=config['base_seed'],
    num_seeds=config['num_seeds'],
    episodes_per_seed=config['episodes_per_seed']
)

traditional_results = run_multi_seed_experiment(
    base_seed=config['base_seed'] + 10000,  # Different seeds
    num_seeds=config['num_seeds'],
    episodes_per_seed=config['episodes_per_seed']
)

# 4. Aggregate results
acp_rewards = np.concatenate([r.rewards for r in acp_results])
traditional_rewards = np.concatenate([r.rewards for r in traditional_results])

# 5. Check assumptions
check_normality(acp_rewards)
check_normality(traditional_rewards)
check_equal_variance(acp_rewards, traditional_rewards)

# 6. Conduct test
test_results = conduct_hypothesis_test(acp_rewards, traditional_rewards)

# 7. Generate report
report = generate_results_report(
    acp_rewards,
    traditional_rewards,
    config,
    output_path='outputs/validation_report.json'
)

# 8. Print summary
print("\n" + "="*60)
print("VALIDATION SUMMARY")
print("="*60)
print(report['interpretation']['conclusion'])
print("="*60)
```

This workflow ensures your results meet research standards for publication and thesis defense.
