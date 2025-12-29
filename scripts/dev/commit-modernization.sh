#!/bin/bash
# Automated commit script for PyMindAffectBCI modernization
# Run from repository root: bash scripts/dev/commit-modernization.sh

set -e  # Exit on error

echo "🚀 Starting automated commit process..."
echo "Total: 16 commits"
echo ""

# Reset staging area
git reset

# Commit 1
echo "📦 [1/16] Removing old build files..."
git add setup.py requirements.txt 2>/dev/null || true
if git diff --cached --quiet; then
    echo "⏭️  Skipping (no changes)"
else
    git commit -m "build: remove deprecated setup.py and requirements.txt

- Removed setup.py (replaced by pyproject.toml)
- Removed requirements.txt (deps now in pyproject.toml)  
- Part of modernization to PEP 517/518 standards"
    echo "✅ Committed"
fi

# Commit 2
echo ""
echo "📦 [2/16] Adding modern build configuration..."
git add pyproject.toml
git commit -m "build: add modern pyproject.toml configuration

- Add PEP 517/518 compliant build configuration
- Define project metadata and dependencies
- Add console script entry point (online_bci)
- Add maintainer information
- Configure ruff for linting
- Specify package-data paths for resources"
echo "✅ Committed"

# Commit 3
echo ""
echo "📦 [3/16] Refactoring to src-layout..."
git add src/mindaffectBCI/__init__.py src/mindaffectBCI/noisetag.py src/mindaffectBCI/online_bci.py src/mindaffectBCI/online_bci.ipynb
git commit -m "refactor: migrate to src-layout structure (part 1: core files)

- Move core package files to src/mindaffectBCI/
- Adopt modern src-based package layout
- Improves package discoverability and testing isolation
- Follows Python packaging best practices (PEP 420)"
echo "✅ Committed"

# Commit 4
echo ""
echo "📦 [4/16] Creating utopia submodule..."
git add src/mindaffectBCI/utopia/
git commit -m "refactor: create utopia submodule for networking

- Move utopiaclient.py to utopia/
- Move utopiaController.py to utopia/
- Move utopia2output.py to utopia/
- Move ssdpDiscover.py to utopia/
- Add utopia/__init__.py with exports
- Organizes network communication layer"
echo "✅ Committed"

# Commit 5
echo ""
echo "📦 [5/16] Creating stimulus submodule..."
git add src/mindaffectBCI/stimulus/
git commit -m "refactor: create stimulus submodule

- Move stimseq.py to stimulus/
- Add stimulus/__init__.py with exports
- Organizes stimulus sequence generation"
echo "✅ Committed"

# Commit 6
echo ""
echo "📦 [6/16] Moving acquisition drivers to package..."
git add src/mindaffectBCI/acquisition/
git commit -m "refactor: move acquisition drivers to package

- Move acquisition/ drivers from examples/ to src/mindaffectBCI/
- Includes 15+ EEG device drivers
- Package components, not examples
- Keeps package self-contained"
echo "✅ Committed"

# Commit 7
echo ""
echo "📦 [7/16] Moving presentation modules to package..."
git add src/mindaffectBCI/presentation/
git commit -m "refactor: move presentation modules to package

- Move presentation/ UIs from examples/ to src/mindaffectBCI/
- Includes selectionMatrix, colorwheel, tictactoe, etc.
- Package components, not examples"
echo "✅ Committed"

# Commit 8
echo ""
echo "📦 [8/16] Moving output handlers to package..."
git add src/mindaffectBCI/output/
git commit -m "refactor: move output handlers to package

- Move output/ from examples/ to src/mindaffectBCI/
- Package components, not examples"
echo "✅ Committed"

# Commit 9
echo ""
echo "📦 [9/16] Moving decoder and hub..."
git add src/mindaffectBCI/decoder/ src/mindaffectBCI/hub/
git commit -m "refactor: move decoder and hub to src layout

- Move decoder/ to src/mindaffectBCI/
- Move hub/ to src/mindaffectBCI/
- Complete src-layout migration"
echo "✅ Committed"

# Commit 10
echo ""
echo "📦 [10/16] Updating imports for utopia submodule..."
git add src/mindaffectBCI/noisetag.py src/mindaffectBCI/__init__.py
git add src/mindaffectBCI/acquisition/*.py src/mindaffectBCI/presentation/*.py
git add src/mindaffectBCI/output/*.py src/mindaffectBCI/decoder/*.py
git add src/mindaffectBCI/utopia/*.py
git commit -m "refactor: update imports for utopia submodule

- Update utopiaclient imports to utopia.utopiaclient
- Update utopiaController imports to utopia.utopiaController
- Fix relative imports within utopia/
- Update 30+ files across acquisition, decoder, presentation, output
- Maintains backward compatibility via __init__.py re-exports"
echo "✅ Committed"

# Commit 11
echo ""
echo "📦 [11/16] Updating imports for stimulus and drivers..."
git add src/mindaffectBCI/online_bci.py
git add --update src/mindaffectBCI/**/*.py
git commit -m "refactor: update imports for stimulus and driver modules

- Update stimseq imports to stimulus.stimseq
- Update acquisition paths (examples.acquisition -> acquisition)
- Update presentation paths (examples.presentation -> presentation)
- Fix module paths in online_bci.py"
echo "✅ Committed"

# Commit 12
echo ""
echo "📦 [12/16] Organizing configuration files..."
git add src/mindaffectBCI/configs/
git add src/mindaffectBCI/online_bci.py
git commit -m "refactor: organize configuration files

- Create configs/ directory
- Move all *.json files to configs/
- Add configs/__init__.py
- Update config search path in online_bci.py
- 12 config files organized"
echo "✅ Committed"

# Commit 13
echo ""
echo "📦 [13/16] Organizing resource files..."
git add src/mindaffectBCI/resources/
git add --update src/mindaffectBCI/**/*.py
git commit -m "refactor: organize resource files

- Create resources/stimuli/ for stimulus sequences
- Create resources/ui_data/ for UI data files
- Move stimulus .txt files to resources/stimuli/
- Move presentation .txt files to resources/ui_data/
- Update file path references
- 13 resource files organized"
echo "✅ Committed"

# Commit 14
echo ""
echo "📦 [14/16] Repository cleanup - scripts..."
git add scripts/
git commit -m "refactor: reorganize scripts and utilities

- Create scripts/ directory structure
- Create scripts/launchers/ for runner scripts
- Create scripts/dev/ for development tools
- Move launcher scripts to scripts/launchers/
- Modernize build script
- Add scripts/README.md"
echo "✅ Committed"

# Commit 15
echo ""
echo "📦 [15/16] Adding test infrastructure..."
git add tests/
git commit -m "test: add pytest infrastructure and initial tests

- Add conftest.py with pytest configuration
- Add test fixtures
- Add test_imports.py for smoke tests
- Add test_noisetag.py for unit tests
- Add test_hierarchy.py for structure validation"
echo "✅ Committed"

# Commit 16
echo ""
echo "📦 [16/16] Updating .gitignore and documentation..."
git add .gitignore README.md
git add examples/ docs/ || true
git commit -m "docs: modernize documentation and project files

- Update .gitignore with Python best practices
- Update README with new structure
- Add module descriptions and examples
- Update file paths in documentation
- Update example references"
echo "✅ Committed"

echo ""
echo "🎉 All 16 commits completed successfully!"
echo ""
echo "Review commits with: git log --oneline -16"
echo "Push to remote with: git push origin main"
