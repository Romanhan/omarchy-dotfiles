#!/usr/bin/env bash
set -euo pipefail

# Get dotfiles repo root (directory where this script lives)
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_SCRIPTS_DIR="$DOTFILES_DIR/install-scripts"

echo "=== Starting dotfiles setup ==="

# 1. Run all app install scripts. install-dotfiles also stows the packages.
echo "=== Installing apps ==="
for script in "$INSTALL_SCRIPTS_DIR"/install-*; do
  if [ -f "$script" ] && [ -x "$script" ]; then
    echo "Running $(basename "$script")..."
    "$script"
  fi
done

echo "=== Setup complete ==="
echo "Restart the shell to apply UI changes: omarchy restart shell"
