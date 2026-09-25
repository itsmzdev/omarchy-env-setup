#!/usr/bin/env bash

set -euo pipefail

echo "===================================================="
echo "       Omarchy: Deploying MongoDB Container         "
echo "===================================================="

# Run the native Omarchy command
echo "📥 Installing docker database..."
omarchy install docker dbs MongoDB

echo "===================================================="
echo "         ✅ MongoDB deployed successfully!          "
echo "===================================================="
