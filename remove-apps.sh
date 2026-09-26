#!/usr/bin/env bash

set -euo pipefail

echo "===================================================="
echo "       Omarchy: Removing Web Apps & Packages        "
echo "===================================================="

# --------------------------------------------------
# 1. Removing Webapps
# --------------------------------------------------
echo -e "\nExecuting: Removing Webapps..."

webapps=(
  "Basecamp"
  "ChatGPT"
  "Discord"
  "Figma"
  "Fizzy"
  "Google Contacts"
  "Google Maps"
  "Google Messages"
  "HEY"
  "YouTube"
)

for app in "${webapps[@]}"; do
  echo "Removing web app: $app"
  omarchy webapp remove "$app"
done

# Skipped webapps: GitHub, Google Photos, WhatsApp, Zoom


# --------------------------------------------------
# 2. Removing Packages
# --------------------------------------------------
echo -e "\nExecuting: Removing Packages..."

omarchy pkg drop \
  typora \
  spotify \
  foot \
  libreoffice-fresh \
  1password-beta \
  1password-cli \
  signal-desktop \
  pinta \
  obsidian \
  obs-studio \
  kdenlive \
  chromium

# Skipped packages: xournalpp, lazydocker, opencode, claude-code

omarchy remove security fido2
omarchy remove security fingerprint


# --------------------------------------------------
# Completion
# --------------------------------------------------
echo "===================================================="
echo "         🎉 All apps removed successfully           "
echo "===================================================="
