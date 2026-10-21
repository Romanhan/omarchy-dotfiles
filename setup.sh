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

# 2. Rebase the dynamic island bar on the installed Omarchy bar. The
# post-update hook does this on `omarchy update`; setup covers fresh installs
# and updates done through pacman/AUR helpers.
echo "=== Refreshing the dynamic island bar ==="
REBUILD="$DOTFILES_DIR/omarchy/.config/omarchy/plugins/romanhan.bar/rebuild"
if [ -x "$REBUILD" ]; then
  "$REBUILD" || echo "Warning: the island patch did not apply; existing bar left untouched."
else
  echo "Warning: $REBUILD not found, skipping."
fi

echo "=== Setup complete ==="
echo "Restart the shell to apply UI changes: omarchy restart shell"
