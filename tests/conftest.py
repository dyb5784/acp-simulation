"""
Pytest configuration and fixtures for ACP simulation tests.
"""

import sys
import os
from pathlib import Path

# Add src directory to Python path for testing
src_path = Path(__file__).parent.parent / "src"
sys.path.insert(0, str(src_path))