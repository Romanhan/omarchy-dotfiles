#!/usr/bin/env bash
set -euo pipefail

# Get dotfiles repo root (directory where this script lives)
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_SCRIPTS_DIR="$DOTFILES_DIR/install-scripts"

echo "=== Starting dotfiles setup ==="

# 1. Run all app install scripts
echo "=== Installing apps ==="
for script in "$INSTALL_SCRIPTS_DIR"/install-*; do
  if [ -f "$script" ] && [ -x "$script" ]; then
    echo "Running $(basename "$script")..."
    "$script"
  fi
done

# 2. Stow all dotfiles packages
echo "=== Stowing dotfiles ==="
cd "$DOTFILES_DIR" || exit 1

STOW_PACKAGES=("bash" "kitty" "hypr" "superfile" "omarchy")
for package in "${STOW_PACKAGES[@]}"; do
  if [ -d "$package" ]; then
    echo "Stowing $package..."
    stow "$package"
  else
    echo "Warning: $package not found, skipping"
  fi
done

echo "=== Setup complete ==="
