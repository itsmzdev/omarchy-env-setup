#!/bin/bash

set -euo pipefail

echo "===================================================="
echo "     Omarchy: Installing Proton Env for Steam       "
echo "===================================================="

omarchy pkg aur add proton-cachyos-slr
omarchy pkg add protontricks

echo "===================================================="
echo "       ✅ Proton env installed successfully!        "
echo "===================================================="
