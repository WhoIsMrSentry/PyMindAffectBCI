# Scripts Directory

This directory contains utility scripts for running and developing PyMindAffectBCI.

## Directory Structure

### `launchers/`
Convenience scripts to launch different components:
- `online_bci.bat` - Launch the complete BCI system
- `ccaViewer.bat` - View CCA analysis
- `erpViewer.bat` - View ERP data
- `sigViewer.bat` - View raw signals
- `fakeSelection.bat` - Run fake selection test
- `startFakeRecogniser.bat` - Start simulated decoder

And corresponding `.sh` scripts for Linux/Mac.

### `dev/`
Development and build tools:
- `build_package.sh` - Build and package the project for PyPI

## Usage

### Windows
```cmd
cd scripts\launchers
online_bci.bat
```

### Linux/Mac
```bash
cd scripts/launchers
./online_bci.sh
```

## Development

### Building the Package
```bash
cd scripts/dev
./build_package.sh
```

This will:
1. Clean old builds
2. Build wheel and source distribution
3. Check package validity
4. Provide upload instructions
