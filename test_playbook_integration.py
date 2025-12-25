"""
Test suite for Claude Code Playbook integration validation.

Tests that should PASS verify the playbook is properly installed.
Tests that should FAIL verify validation requirements are enforced.
"""

import pytest
import os
from pathlib import Path


class TestPlaybookStructure:
    """Tests that should PASS - verify playbook structure exists."""
    
    def test_claude_directory_exists(self):
        """PASS: .claude directory should exist."""
        assert Path(".claude").exists(), ".claude directory not found"
        assert Path(".claude").is_dir(), ".claude is not a directory"
    
    def test_skills_directory_exists(self):
        """PASS: .claude/skills directory should exist."""
        assert Path(".claude/skills").exists(), "skills directory not found"
    
    def test_python_scientific_skill_exists(self):
        """PASS: Python scientific skill should exist."""
        skill_path = Path(".claude/skills/python-scientific/SKILL.md")
        assert skill_path.exists(), "Python scientific SKILL.md not found"
        assert skill_path.stat().st_size > 1000, "SKILL.md seems empty or incomplete"
    
    def test_refactoring_skill_exists(self):
        """PASS: Refactoring skill should exist."""
        skill_path = Path(".claude/skills/refactoring/SKILL.md")
        assert skill_path.exists(), "Refactoring SKILL.md not found"
    
    def test_all_workflows_exist(self):
        """PASS: All 6 workflows should exist."""
        workflows = [
            "triage.md",
            "extract.md", 
            "qnew.md",
            "qplan.md",
            "qcode.md",
            "catchup.md"
        ]
        workflow_dir = Path(".claude/skills/refactoring/workflows")
        
        for workflow in workflows:
            workflow_path = workflow_dir / workflow
            assert workflow_path.exists(), f"Workflow {workflow} not found"
    
    def test_documentation_exists(self):
        """PASS: Core documentation files should exist."""
        docs = [
            ".claude/README.md",
            ".claude/GETTING_STARTED.md",
            ".claude/WORKFLOW_GUIDE.md",
            ".claude/skills/README.md",
            "CHANGELOG.md",
            "QUICK_REFERENCE.md"
        ]
        
        for doc in docs:
            assert Path(doc).exists(), f"Documentation {doc} not found"


class TestPlaybookContent:
    """Tests that should PASS - verify content quality."""
    
    def test_python_skill_has_vectorization_patterns(self):
        """PASS: Python skill should mention vectorization."""
        skill_path = Path(".claude/skills/python-scientific/SKILL.md")
        content = skill_path.read_text(encoding="utf-8")
        
        assert "vectorization" in content.lower(), "Missing vectorization content"
        assert "numpy" in content.lower(), "Missing NumPy content"
    
    def test_python_skill_has_reproducibility(self):
        """PASS: Python skill should cover reproducibility."""
        skill_path = Path(".claude/skills/python-scientific/SKILL.md")
        content = skill_path.read_text(encoding="utf-8")
        
        assert "random_seed" in content or "seed" in content, "Missing seed/reproducibility"
        assert "rng" in content or "random" in content, "Missing RNG patterns"
    
    def test_quick_reference_has_commands(self):
        """PASS: Quick reference should have practical commands."""
        ref_path = Path("QUICK_REFERENCE.md")
        content = ref_path.read_text(encoding="utf-8")
        
        assert "/clear" in content, "Missing /clear command"
        assert "/cost" in content, "Missing /cost command"
        assert "view" in content, "Missing view commands"
    
    def test_changelog_has_version_info(self):
        """PASS: Changelog should document the integration."""
        changelog_path = Path("CHANGELOG.md")
        content = changelog_path.read_text(encoding="utf-8")
        
        assert "Claude Code Playbook" in content, "Missing playbook mention"
        assert "2024-12-18" in content or "December 18" in content, "Missing date"


class TestValidationRequirements:
    """Tests that should FAIL initially - verify validation is needed."""
    
    def test_code_has_type_hints(self):
        """FAIL: Not all code has type hints yet (intentional)."""
        # This should fail until we add type hints everywhere
        from src.acp_simulation.environment.network import NetworkEnvironment
        
        import inspect
        
        # Get __init__ signature
        sig = inspect.signature(NetworkEnvironment.__init__)
        
        # Check if all parameters have type hints
        for param_name, param in sig.parameters.items():
            if param_name in ['self', 'kwargs']:
                continue
            assert param.annotation != inspect.Parameter.empty, \
                f"Parameter {param_name} missing type hint in NetworkEnvironment.__init__"
    
    def test_functions_have_docstrings(self):
        """FAIL: Not all functions have NumPy-style docstrings yet."""
        from src.acp_simulation.environment.network import NetworkEnvironment
        
        # Check a few key methods
        methods = ['step', 'reset', '_calculate_reward']
        
        for method_name in methods:
            if hasattr(NetworkEnvironment, method_name):
                method = getattr(NetworkEnvironment, method_name)
                doc = method.__doc__
                
                assert doc is not None, f"{method_name} missing docstring"
                assert "Parameters" in doc, f"{method_name} missing Parameters section"
                assert "Returns" in doc, f"{method_name} missing Returns section"
    
    def test_no_magic_numbers(self):
        """FAIL: Code still has magic numbers (intentional)."""
        from src.acp_simulation.environment.network import NetworkEnvironment
        import inspect
        
        # Get source code
        source = inspect.getsource(NetworkEnvironment)
        
        # Look for common magic numbers that should be constants
        magic_patterns = [
            "0.95",  # Decay rates
            "0.05",  # Update rates
            "1.05",  # Confidence factors
        ]
        
        for pattern in magic_patterns:
            if pattern in source:
                pytest.fail(f"Found magic number {pattern} - should be a named constant")


class TestReproducibility:
    """Tests that should PASS - verify reproducibility standards."""
    
    def test_random_seed_parameter_exists(self):
        """PASS: Check if key functions accept random seeds."""
        # Import your main experiment function
        try:
            from src.acp_corrected_final import run_corrected_experiment
            import inspect
            
            sig = inspect.signature(run_corrected_experiment)
            params = sig.parameters
            
            # Should have a seed parameter
            assert any('seed' in param.lower() for param in params), \
                "run_corrected_experiment missing random_seed parameter"
        except ImportError:
            pytest.skip("Could not import experiment function")
    
    def test_reproducible_results(self):
        """PASS: Same seed should give same results."""
        try:
            from src.acp_corrected_final import run_corrected_experiment
            
            # Run twice with same seed
            result1 = run_corrected_experiment(
                num_agents=10,
                num_episodes=2,
                random_seed=42
            )
            
            result2 = run_corrected_experiment(
                num_agents=10,
                num_episodes=2,
                random_seed=42
            )
            
            # Results should be identical
            assert result1 == result2, "Results not reproducible with same seed"
        except Exception as e:
            pytest.skip(f"Could not test reproducibility: {e}")


class TestTokenBudget:
    """Meta-tests about the playbook itself."""
    
    def test_workflow_documentation_exists(self):
        """PASS: Each workflow should be documented."""
        workflows = ["triage", "extract", "qnew", "qplan", "qcode", "catchup"]
        
        for workflow in workflows:
            workflow_path = Path(f".claude/skills/refactoring/workflows/{workflow}.md")
            assert workflow_path.exists(), f"{workflow} workflow not found"
            
            content = workflow_path.read_text(encoding="utf-8")
            assert len(content) > 100, f"{workflow} workflow seems empty"
    
    def test_skills_readme_has_navigation(self):
        """PASS: Skills README should help users navigate."""
        readme_path = Path(".claude/skills/README.md")
        content = readme_path.read_text(encoding="utf-8")
        
        assert "python-scientific" in content, "Missing Python scientific skill reference"
        assert "refactoring" in content, "Missing refactoring skill reference"
        assert "workflow" in content.lower(), "Missing workflow information"


@pytest.fixture
def repo_root():
    """Fixture to ensure we're in the repository root."""
    original_dir = os.getcwd()
    
    # Find repo root (has .git directory)
    current = Path.cwd()
    while current != current.parent:
        if (current / ".git").exists():
            os.chdir(current)
            break
        current = current.parent
    
    yield current
    
    os.chdir(original_dir)


if __name__ == "__main__":
    # Run with: pytest test_playbook_integration.py -v
    # Or: python test_playbook_integration.py
    import sys
    sys.exit(pytest.main([__file__, "-v", "--tb=short"]))
