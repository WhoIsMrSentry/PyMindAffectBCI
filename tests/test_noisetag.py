"""Unit tests for noisetag module."""
import pytest


def test_noisetag_instantiation(sample_stimulus_file):
    """Test that Noisetag can be instantiated."""
    from mindaffectBCI import Noisetag
    
    nt = Noisetag(stimFile=str(sample_stimulus_file))
    assert nt is not None


def test_noisetag_default_params():
    """Test Noisetag with default parameters."""
    from mindaffectBCI import Noisetag
    
    # Should work without stimFile in test mode
    nt = Noisetag(clientid='test')
    assert nt.clientid == 'test'
