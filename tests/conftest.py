"""Test configuration for pytest."""
import pytest
import sys
from pathlib import Path

# Add src to Python path
src_path = Path(__file__).parent.parent / "src"
sys.path.insert(0, str(src_path))


@pytest.fixture
def mock_utopia_connection():
    """Mock Utopia connection for testing."""
    return None


@pytest.fixture
def sample_stimulus_file(tmp_path):
    """Create a temporary stimulus file for testing."""
    stim_file = tmp_path / "test_stim.txt"
    stim_file.write_text("0 1 0 1\n")
    return stim_file
