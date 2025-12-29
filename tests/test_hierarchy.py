import sys
import os

# Add src to sys.path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '../src')))

import mindaffectBCI
from mindaffectBCI.noisetag import Noisetag
import mindaffectBCI.utopia
import mindaffectBCI.stimulus

def test_hierarchy():
    print("Testing hierarchy imports...")
    try:
        from mindaffectBCI.utopia.utopiaclient import UtopiaClient
        print("Successfully imported UtopiaClient from mindaffectBCI.utopia.utopiaclient")
    except ImportError as e:
        print(f"Failed to import UtopiaClient: {e}")
        raise

    try:
        from mindaffectBCI.stimulus.stimseq import StimSeq
        print("Successfully imported StimSeq from mindaffectBCI.stimulus.stimseq")
    except ImportError as e:
        print(f"Failed to import StimSeq: {e}")
        raise

    # Test drivers
    try:
        from mindaffectBCI.acquisition import utopia_fakedata
        print("Successfully imported utopia_fakedata from mindaffectBCI.acquisition")
    except ImportError as e:
        print(f"Failed to import utopia_fakedata: {e}")
        raise

    try:
        from mindaffectBCI.presentation import selectionMatrix
        print("Successfully imported selectionMatrix from mindaffectBCI.presentation")
    except ImportError as e:
        print(f"Failed to import selectionMatrix: {e}")
        raise
        
    # Test re-exports
    try:
        from mindaffectBCI import UtopiaClient as UC_Top
        from mindaffectBCI import UtopiaController as UC_Ctrl_Top
        print("Successfully imported Utopia classes from top-level mindaffectBCI")
    except ImportError as e:
        print(f"Failed to import top-level aliases: {e}")
        raise

def test_noisetag_instantiation():
    # Mock stim file or create one
    with open("test_stim.txt", "w") as f:
        f.write("0 1 0 1\n") 
    
    try:
        nt = Noisetag(stimFile="test_stim.txt")
        print("Noisetag instantiated successfully")
    except Exception as e:
        print(f"Noisetag instantiation failed: {e}")
        raise
    finally:
        if os.path.exists("test_stim.txt"):
            os.remove("test_stim.txt")

if __name__ == "__main__":
    print("Running hierarchy verification...")
    test_hierarchy()
    test_noisetag_instantiation()
    print("ALL TESTS PASSED")
