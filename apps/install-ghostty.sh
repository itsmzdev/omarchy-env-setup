#!/bin/bash

set -euo pipefail

echo "===================================================="
echo "     Omarchy: Installing Brave Origin Browser       "
echo "===================================================="

omarchy install terminal ghostty

echo "Making Brave as a Default Browser"
omarchy default terminal ghostty

echo "===================================================="
echo "        ✅ Browser installed successfully!          "
echo "===================================================="

