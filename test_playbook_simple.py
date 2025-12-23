"""
Simple test suite for Claude Code Playbook validation.

Run with: pytest test_playbook_simple.py -v

Tests are organized into:
1. SHOULD PASS: Validates playbook is installed correctly
2. SHOULD FAIL: Validates code improvements are needed
"""

import pytest
from pathlib import Path


# ============================================================================
# SECTION 1: Tests that SHOULD PASS
# These verify the playbook is installed correctly
# ============================================================================

def test_pass_claude_directory_exists():
    """✓ SHOULD PASS: .claude directory exists."""
    assert Path(".claude").exists()

def test_pass_python_skill_exists():
    """✓ SHOULD PASS: Python scientific skill file exists."""
    assert Path(".claude/skills/python-scientific/SKILL.md").exists()

def test_pass_refactoring_skill_exists():
    """✓ SHOULD PASS: Refactoring skill file exists."""
    assert Path(".claude/skills/refactoring/SKILL.md").exists()

def test_pass_triage_workflow_exists():
    """✓ SHOULD PASS: Triage workflow exists."""
    assert Path(".claude/skills/refactoring/workflows/triage.md").exists()

def test_pass_extract_workflow_exists():
    """✓ SHOULD PASS: Extract workflow exists."""
    assert Path(".claude/skills/refactoring/workflows/extract.md").exists()

def test_pass_qnew_workflow_exists():
    """✓ SHOULD PASS: Qnew workflow exists."""
    assert Path(".claude/skills/refactoring/workflows/qnew.md").exists()

def test_pass_changelog_exists():
    """✓ SHOULD PASS: CHANGELOG.md exists."""
    assert Path("CHANGELOG.md").exists()

def test_pass_quick_reference_exists():
    """✓ SHOULD PASS: QUICK_REFERENCE.md exists."""
    assert Path("QUICK_REFERENCE.md").exists()

def test_pass_python_skill_mentions_numpy():
    """✓ SHOULD PASS: Python skill mentions NumPy."""
    content = Path(".claude/skills/python-scientific/SKILL.md").read_text(encoding="utf-8")
    assert "numpy" in content.lower()

def test_pass_python_skill_mentions_vectorization():
    """✓ SHOULD PASS: Python skill mentions vectorization."""
    content = Path(".claude/skills/python-scientific/SKILL.md").read_text(encoding="utf-8")
    assert "vectorization" in content.lower()

def test_pass_quick_ref_has_clear_command():
    """✓ SHOULD PASS: Quick reference has /clear command."""
    content = Path("QUICK_REFERENCE.md").read_text(encoding="utf-8")
    assert "/clear" in content


# ============================================================================
# SECTION 2: Tests that SHOULD FAIL (until we improve the code)
# These identify areas needing improvement per playbook standards
# ============================================================================

@pytest.mark.xfail(reason="Code doesn't have type hints yet - needs improvement")
def test_fail_network_environment_has_type_hints():
    """✗ SHOULD FAIL: NetworkEnvironment needs type hints."""
    import inspect
    from src.acp_simulation.environment.network import NetworkEnvironment
    
    # Check __init__ has type hints
    sig = inspect.signature(NetworkEnvironment.__init__)
    for param_name, param in sig.parameters.items():
        if param_name == 'self':
            continue
        # This will fail because not all params have type hints
        assert param.annotation != inspect.Parameter.empty, \
            f"Missing type hint on {param_name}"

@pytest.mark.xfail(reason="Functions don't have NumPy-style docstrings yet")
def test_fail_functions_have_numpy_docstrings():
    """✗ SHOULD FAIL: Functions need NumPy-style docstrings."""
    from src.acp_simulation.environment.network import NetworkEnvironment
    
    method = NetworkEnvironment.step
    doc = method.__doc__
    
    # This will fail because docstring isn't NumPy style
    assert doc is not None, "Missing docstring"
    assert "Parameters" in doc, "Missing Parameters section"
    assert "----------" in doc, "Missing NumPy-style formatting"
    assert "Returns" in doc, "Missing Returns section"

@pytest.mark.xfail(reason="Code has magic numbers that should be constants")
def test_fail_no_magic_numbers_in_network():
    """✗ SHOULD FAIL: Code has magic numbers."""
    import inspect
    from src.acp_simulation.environment.network import NetworkEnvironment
    
    source = inspect.getsource(NetworkEnvironment)
    
    # Check for common magic numbers
    magic_numbers = ["0.95", "0.05", "1.05"]
    
    for magic in magic_numbers:
        # This will fail if magic numbers exist
        assert magic not in source, f"Found magic number {magic} - should be a constant"

@pytest.mark.xfail(reason="NetworkEnvironment is a god object (330 lines)")
def test_fail_network_environment_is_too_large():
    """✗ SHOULD FAIL: NetworkEnvironment is too large (god object)."""
    import inspect
    from src.acp_simulation.environment.network import NetworkEnvironment
    
    source = inspect.getsource(NetworkEnvironment)
    lines = len(source.split('\n'))
    
    # Should be < 200 lines per playbook standards
    assert lines < 200, f"NetworkEnvironment is {lines} lines (should be < 200)"

@pytest.mark.xfail(reason="Not using numpy.typing for type hints yet")
def test_fail_using_numpy_typing():
    """✗ SHOULD FAIL: Code should use numpy.typing."""
    from src.acp_simulation.environment.network import NetworkEnvironment
    import inspect
    
    source = inspect.getsource(NetworkEnvironment)
    
    # Should import from numpy.typing
    assert "from numpy.typing import NDArray" in source, \
        "Should use numpy.typing.NDArray for type hints"


# ============================================================================
# Convenience function to run tests
# ============================================================================

if __name__ == "__main__":
    import sys
    
    print("=" * 70)
    print("Claude Code Playbook Integration Tests")
    print("=" * 70)
    print()
    print("PASS tests: Verify playbook is installed correctly")
    print("FAIL tests: Identify areas needing improvement")
    print()
    print("=" * 70)
    
    # Run tests
    exit_code = pytest.main([
        __file__,
        "-v",
        "--tb=short",
        "-k", "test_pass or test_fail"
    ])
    
    print()
    print("=" * 70)
    print("Summary:")
    print("  - Tests that PASSED: Playbook structure is correct ✓")
    print("  - Tests that FAILED: Code needs improvement (expected) ✗")
    print("=" * 70)
    
    sys.exit(exit_code)
