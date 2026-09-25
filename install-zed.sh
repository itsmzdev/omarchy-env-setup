#!/bin/bash

set -euo pipefail

echo "===================================================="
echo "           Omarchy: Installing Zed                  "
echo "===================================================="

omarchy install editor zed

echo "Making Zed as a Default Editor"
omarchy default editor zed

echo "===================================================="
echo "         ✅ VSCode installed successfully!          "
echo "===================================================="
