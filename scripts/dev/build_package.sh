#!/bin/bash
# Modern package build script for PyMindAffectBCI
# Uses pyproject.toml instead of setup.py

set -e  # Exit on error

echo "🧹 Cleaning old builds..."
rm -rf dist/* build/* *.egg-info

echo "📦 Building package..."
python3 -m build

echo "✅ Checking package..."
python3 -m twine check dist/*

echo ""
echo "📋 Build complete! Next steps:"
echo ""
echo "To test on TestPyPI:"
echo "  python3 -m twine upload --repository testpypi dist/*"
echo ""
echo "To upload to PyPI:"
echo "  python3 -m twine upload dist/*"
echo ""
echo "To test installation:"
echo "  python3 -m pip install dist/*.whl"
