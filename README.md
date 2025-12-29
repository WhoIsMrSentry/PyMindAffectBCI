# mindaffectBCI

## Maintainer Notice
**This repository has been modernized and is now maintained by Emir Hüseyin.**

The codebase has been refactored to follow modern Python packaging standards with improved modularity.

## Info
----------------------------------

This repository contains the python SDK code for the Brain Computer Interface (BCI) developed by the company `Mindaffect <https://mindaffect.nl>`_.

When installed, with the right hardware you can do things like shown `here <https://youtu.be/MVuQzaqDkKI>`_


Online Documentation and Tutorials
----------------------------------
Available at: `https://mindaffect-bci.readthedocs.io/ <https://mindaffect-bci.readthedocs.io/en/latest/tutorials.html>`_

## Installation

### From Source (Recommended)

1. Clone or download this repository:
   ```bash
   git clone https://github.com/mindaffect/pymindaffectBCI
   cd pymindaffectBCI
   ```

2. Install the package:
   ```bash
   pip install -e .
   ```

### From PyPI
```bash
pip install --upgrade mindaffectBCI
```

Try the off-line analysis on-line on binder.

.. image:: https://mybinder.org/badge_logo.svg
 :target: https://mybinder.org/v2/gh/mindaffect/pymindaffectBCI/pip_test

Try off-line multiple datasets analysis on `kaggle <https://www.kaggle.com/mindaffect/mindaffectbci>`_ 



Installation Test
-----------------

You can run a quick test if the installation without any additional hardware by running::

  python3 -m mindaffectBCI.online_bci --acquisition fakedata

Essentially, this run the SDK test code which simulates a *fake* EEG source and then runs the full BCI sequence, with decoder discovery, calibration and prediction.

If all is successfully installed then you should see a window like this open up.

<img src='docs/source/images/mainmenu.png' width=300>

If you now press 2 you should see a flickering grid of "buttons" like below.  You should see a random one briefly flash green (it's the target) then rapidly flicker and eventually turn blue (to indicate it's selected.)

<img src='docs/source/images/selectionmatrix.png' width=300>

If all this works then you have successfully installed the mindaffectBCI python software. You should now ensure your hardware (display, amplifier) is correctly configured before jumping into BCI control.


Important: FrameRate Check
--------------------------

For rapid visual stimulation BCI (like the noisetagging BCI), it is *very* important that the visual flicker be displayed *accurately*.  However, as the graphics performance of computers varies widely it is hard to know in advance if a particular configuration is accurate enough.  To help with this we also provide a graphics performance checker, which will validate that your graphics system is correctly configured.  You can run this with::

  python3 -m mindaffectBCI.presentation.framerate_check

As this runs it will show in a window your current graphics frame-rate and, more importantly, the variability in the frame times.  For good BCI performance this jitter should be <1ms.  If you see jitter greater than this you should probably adjust your graphics card settings.  The most important setting to consider is to be sure that you  have `_vsync_ <https://en.wikipedia.org/wiki/Screen_tearing#Vertical_synchronization>` *turned-on*.  Many graphics cards turn this off by default, as it (in theory) gives higher frame rates for gaming.  However, for our system, frame-rate is less important than *exact*  timing, hence always turn vsync on for visual Brain-Compuber-Interfaces!


Brain Computer Interface Test
-----------------------------

If you have:
  1. installed `pyglet <https://pyglet.org>`_ , e.g. using `pip3 install pyglet`
  #. installed `brainflow <https://brainflow.org>`_ , e.g. using `pip3 install brainflow`
  #. have connected an `openBCI ganglion <https://shop.openbci.com>`_ ,
  #. have followed `MindAffect headset layout.pdf <https://github.com/mindaffect/Headset/blob/master/MindAffect%20headset%20layout.pdf>`_ to attach the electrodes to the back of your head.

Then you can jump directly to trying a fully functional simple letter matrix BCI using::

  python3 -m mindaffectBCI.online_bci

Note: For more information on how to run an on-line BCI, *including using other supported amplifiers*, see our complete `on-line documentation <mindaffect-bci.readthedocs.io>`_ and in particular our `tutorials section <https://mindaffect-bci.readthedocs.io/en/latest/tutorials.html>`_.

Getting Support
---------------

If you run into and issue you can either directly raise an issue on the projects `github page <https://github.com/mindaffect/pymindaffectBCI>`_ 

..
    or directly contact the developers on `gitter <https://gitter.im/mindaffect>`_ -- to complain, complement, or just chat:

    .. image:: https://badges.gitter.im/mindaffect/unitymindaffectBCI.svg
      :target: https://gitter.im/mindaffect/pymindaffectBCI?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge


## File Structure

This repository follows a modern `src`-based layout with modular organization:

```
PyMindAffectBCI/
├── src/mindaffectBCI/        # Main package
│   ├── utopia/               # Network communication
│   │   ├── utopiaclient.py   # Low-level messaging
│   │   └── utopiaController.py # High-level API
│   ├── stimulus/             # Stimulus sequence generation
│   │   └── stimseq.py
│   ├── acquisition/          # EEG hardware drivers
│   ├── presentation/         # UI modules
│   │   └── selectionMatrix.py # Selection interface
│   ├── output/               # Action handlers
│   ├── decoder/              # BCI decoder & analysis
│   │   └── decoder.py        # Online decoder
│   ├── hub/                  # Central hub
│   ├── configs/              # Configuration files (.json)
│   ├── resources/
│   │   └── stimuli/          # Stimulus sequences (.txt)
│   ├── noisetag.py           # Main BCI API
│   └── online_bci.py         # Entry point
├── examples/                 # Example scripts
│   └── utilities/
├── docs/                     # Documentation
└── tests/                    # Test files
```

### Key Modules

- **noisetag.py** - Main API for developing BCI-controlled UIs
- **utopia/** - Communication with MindAffect decoder
- **stimulus/** - Stimulus codebook management  
- **acquisition/** - EEG hardware interface drivers
- **presentation/** - User interface examples
- **decoder/** - Open-source BCI decoder

## Module Descriptions

### Core BCI API

#### `noisetag.py`
Main high-level API for developing BCI applications. Provides:
- **Noisetag class**: Main interface for BCI control
- Finite State Machine (FSM) for BCI workflow management
- Automatic calibration and prediction phases
- Event handling and selection callbacks
- Simple integration for UI developers

**Example Usage:**
```python
from mindaffectBCI import Noisetag

nt = Noisetag()
nt.connect()  # Connect to decoder
nt.setnumActiveObjIDs(9)  # 9 selectable objects
nt.startCalibration()  # Run calibration
nt.startPrediction()  # Start prediction mode
```

### Network Communication (`utopia/`)

#### `utopiaclient.py`
Low-level networking and message protocol:
- Message serialization/deserialization
- Socket communication with hub
- Message types: StimulusEvent, DataPacket, Selection, etc.
- Timestamp synchronization

#### `utopiaController.py`
High-level controller for decoder interaction:
- Simplified API for sending/receiving messages
- Event handlers for predictions and selections  
- Automatic connection management
- Signal quality monitoring

**Example Usage:**
```python
from mindaffectBCI.utopia import UtopiaController

uc = UtopiaController()
uc.autoconnect()
uc.sendStimulusEvent([1, 0, 1, 0], timestamp=None)
msgs = uc.getNewMessages()
```

### Stimulus Generation (`stimulus/`)

#### `stimseq.py`
Manages stimulus sequences (codebooks):
- Loads pre-defined stimulus patterns (.txt files)
- Generates random/pseudo-random sequences
- Supports various modulation codes (m-sequence, Gold codes)
- Frame-rate adaptive sequencing

### Hardware Drivers (`acquisition/`)

Multiple EEG device drivers:
- **`utopia_brainflow.py`** - BrainFlow supported devices (OpenBCI, etc.)
- **`utopia_lsl.py`** - Lab Streaming Layer (LSL) interface
- **`utopia_fakedata.py`** - Simulated data for testing
- **`utopia_eego.py`** - ANT Neuro eego devices
- And 10+ more device-specific drivers

All drivers follow the same pattern:
1. Connect to hardware
2. Stream data packets to hub
3. Handle trigger injection for testing

### User Interfaces (`presentation/`)

#### `selectionMatrix.py`
Main selection interface with:
- Grid of selectable objects (letters, symbols, images)
- Configurable stimulus rendering
- Calibration and prediction visualization
- Feedback animations

#### Other UIs:
- `colorwheel.py` - Circular color selector
- `tictactoe.py` - BCI-controlled game
- `framerate_check.py` - Display validation tool

### Signal Processing (`decoder/`)

#### `decoder.py`
Real-time BCI decoder:
- Multi-channel EEG processing
- Canonical Correlation Analysis (CCA)
- Template matching algorithms
- Online adaptation
- Prediction generation

#### `offline_analysis.ipynb`
Jupyter notebook for:
- Post-hoc data analysis
- Performance evaluation
- Algorithm parameter tuning
- Visualization of results

### Configuration (`configs/`)

JSON configuration files for different BCI setups:
- `online_bci.json` - Default online BCI config
- `noisetag_bci.json` - Noisetag-specific settings
- `debug.json` - Debug mode configuration
- Device-specific configs (raspberry_pi_gpio.json, etc.)

### Resources (`resources/`)

#### `stimuli/`
Pre-computed stimulus sequences:
- `mgold_61_6521_psk_60hz.txt` - Gold code sequence for 60Hz displays
- `mgold_65_6532_psk_60hz.txt` - Alternative Gold code
- `rc5x5.txt` - 5x5 matrix code
- `ssvep.txt` - SSVEP (Steady-State Visual Evoked Potential) patterns

## Quick Start Examples

### Testing Installation
```bash
# Run with simulated data
python3 -m mindaffectBCI.online_bci --acquisition fakedata
```

### Basic BCI Application
```python
from mindaffectBCI import Noisetag

# Initialize
nt = Noisetag()
nt.connect()

# Configure for 9 objects
nt.setnumActiveObjIDs(9)

# Run calibration
print("Starting calibration...")
nt.startCalibration()

# Run prediction
print("Starting prediction...")
nt.startPrediction()

# Get selection
selection = nt.getLastSelection()
print(f"Selected: {selection}")
```

### Custom Stimulus Presentation
```python
from mindaffectBCI import Noisetag
import pyglet

nt = Noisetag()
nt.connect()

# Your custom rendering loop
while True:
    # Get stimulus state
    stimulus_state = nt.getStimulusState()
    
    # Render your UI based on stimulus_state
    render_ui(stimulus_state)
    
    # Send stimulus event
    nt.sendStimulusState()
```

- `docs <docs/>`_ -- contains the documentation.

  - `source <docs/source>`_ -- contains the source for the documentation, in particular this directory contains the juypter notebooks for tutorials on how to use the mindaffectBCI.
  
    - `online_bci.ipynb <docs/source/quickstart.ipynb>`_ - This `juypter <https://jupyter.org/>`_ notebook contains the code to run a complete on-line noise-tagging BCI
