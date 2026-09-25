#!/usr/bin/env bash

set -euo pipefail

# Configuration
REPOS_DIR="$HOME/repos"
OMARCHY_REPO_SSH="git@github.com:itsmzdev/omarchy-env-setup.git"
OMARCHY_REPO_HTTPS="https://github.com/itsmzdev/omarchy-env-setup.git"
DOTFILES_REPO_SSH="git@github.com:itsmzdev/dotfiles.git"
DOTFILES_REPO_HTTPS="https://github.com/itsmzdev/dotfiles.git"

clone_repo() {
  local repo_name="$1"
  local ssh_url="$2"
  local https_url="$3"
  local destination="$4"
  local clone_tmp

  clone_tmp=$(mktemp -d "$REPOS_DIR/.${repo_name}.clone.XXXXXX")

  echo "📥 Trying to clone $repo_name over SSH..."
  if GIT_SSH_COMMAND='ssh -o BatchMode=yes -o ConnectTimeout=5' \
    git clone "$ssh_url" "$clone_tmp" 2>/dev/null; then
    mv "$clone_tmp" "$destination"
    return
  fi

  rm -rf -- "$clone_tmp"
  clone_tmp=$(mktemp -d "$REPOS_DIR/.${repo_name}.clone.XXXXXX")

  echo "ℹ️ SSH clone unavailable; trying HTTPS..."
  if git clone "$https_url" "$clone_tmp"; then
    mv "$clone_tmp" "$destination"
    return
  fi

  rm -rf -- "$clone_tmp"
  echo "❌ Could not clone $repo_name using SSH or HTTPS." >&2
  return 1
}

echo "===================================================="
echo "       Omarchy: Setting Up Environments...          "
echo "===================================================="

# --------------------------------------------------
# Phase 1: Repository Checks
# --------------------------------------------------
echo -e "\n📦 Checking structural environment..."
mkdir -p "$REPOS_DIR"

# Check & Clone omarchy-env-setup
if [ ! -d "$REPOS_DIR/omarchy-env-setup" ]; then
  clone_repo "omarchy-env-setup" "$OMARCHY_REPO_SSH" "$OMARCHY_REPO_HTTPS" \
    "$REPOS_DIR/omarchy-env-setup"
else
  echo "✅ omarchy-env-setup directory detected."
fi

# Check & Clone dotfiles
if [ ! -d "$REPOS_DIR/dotfiles" ]; then
  clone_repo "dotfiles" "$DOTFILES_REPO_SSH" "$DOTFILES_REPO_HTTPS" \
    "$REPOS_DIR/dotfiles"
else
  echo "✅ dotfiles directory detected."
fi

# Move into the omarchy-env-setup folder where the sub-scripts live
cd "$REPOS_DIR/omarchy-env-setup"


# --------------------------------------------------
# Phase 2: Sequential Execution
# --------------------------------------------------
echo -e "\n🚀 Starting execution pipeline..."
echo "------------------------------------------------"

# 1. Install preferred system applications
if [ -f "./install-apps.sh" ]; then
  echo "🛠️ Step 1: Running core installation suite..."
  chmod +x ./install-apps.sh
  ./install-apps.sh
fi

# 2. Remove unwanted apps/bloat
if [ -f "./remove-apps.sh" ]; then
  echo "🔥 Step 2: Removing unwanted packages..."
  chmod +x ./remove-apps.sh
  ./remove-apps.sh
fi

# 3. Back up existing configs and stow every discovered dotfiles package
DOTSYNC_SCRIPT="$REPOS_DIR/dotfiles/dotSync.sh"
if [ -f "$DOTSYNC_SCRIPT" ]; then
  echo "🔗 Step 3: Backing up and stowing user environment configurations..."
  bash "$DOTSYNC_SCRIPT"
else
  echo "❌ Error: dotSync.sh not found at $DOTSYNC_SCRIPT" >&2
  exit 1
fi

echo "===================================================="
echo " 🎉 System environment Setup completed successfully!"
echo "===================================================="
