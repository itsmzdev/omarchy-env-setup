#!/usr/bin/env bash

set -euo pipefail

echo "===================================================="
echo "    Omarchy: Installing Apps...                     "
echo "===================================================="

# Define the exact order of installation scripts
installers=(
  "./apps/install-brave-origin.sh"
  "./apps/install-ghostty.sh"
  "./apps/install-vscode.sh"
  "./apps/install-zed.sh"
  "./apps/install-node.sh"
  "./apps/install-codex.sh"
  "./apps/install-mongodb.sh"
  "./apps/install-mysql.sh"
  "./apps/install-stow.sh"
  # "./apps/install-qbittorrent.sh"
  # "./apps/install-qpwgraph.sh"
  # "./apps/install-steam.sh"
  # "./apps/install-proton-env.sh"
)

echo -e "\nRunning individual application modules..."
echo "------------------------------------------------"

# Validate every module before making changes, so an incomplete checkout
# cannot produce a partial install followed by a misleading success message.
for script in "${installers[@]}"; do
  if [[ ! -f "$script" ]]; then
    echo "❌ Error: Required installer not found: $script" >&2
    exit 1
  fi
done

# Execute each installer in an isolated Bash process.
for script in "${installers[@]}"; do
  echo "Executing: $(basename "$script")"
  bash "$script"
done

echo "===================================================="
echo "       🎉 All apps installed successfully!          "
echo "===================================================="
