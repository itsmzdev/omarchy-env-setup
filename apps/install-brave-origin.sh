#!/bin/bash

set -euo pipefail

echo "===================================================="
echo "     Omarchy: Installing Brave Origin Browser       "
echo "===================================================="

omarchy install browser brave-origin

echo "Making Brave as a Default Browser"
omarchy default browser brave-origin

echo "===================================================="
echo "        ✅ Browser installed successfully!          "
echo "===================================================="

