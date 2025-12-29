"""Basic smoke tests for package imports."""
import pytest


def test_import_mindaffectBCI():
    """Test that main package can be imported."""
    import mindaffectBCI
    assert mindaffectBCI is not None


def test_import_noisetag():
    """Test Noisetag class import."""
    from mindaffectBCI import Noisetag
    assert Noisetag is not None


def test_import_utopia():
    """Test utopia submodule imports."""
    from mindaffectBCI.utopia import UtopiaClient, UtopiaController
    assert UtopiaClient is not None
    assert UtopiaController is not None


def test_import_stimulus():
    """Test stimulus submodule import."""
    from mindaffectBCI.stimulus import StimSeq
    assert StimSeq is not None


def test_top_level_exports():
    """Test that key classes are exported at top level."""
    from mindaffectBCI import UtopiaClient, UtopiaController, Noisetag
    assert UtopiaClient is not None
    assert UtopiaController is not None
    assert Noisetag is not None
