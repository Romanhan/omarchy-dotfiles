#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_SCRIPTS_DIR="$DOTFILES_DIR/install-scripts"

echo "=== Starting dotfiles setup ==="

# 1. Install apps. The master script runs each app installer separately and
# reports failures without stopping the rest of setup.
echo "=== Installing apps ==="
app_status=0
if ! "$INSTALL_SCRIPTS_DIR/install-apps"; then
  app_status=1
fi

# 2. Link the dotfiles. This runs after app installers because flea --default
# may rewrite Hyprland's bindings file; install-dotfiles backs it up and links
# the repo version afterwards.
echo "=== Linking dotfiles ==="
"$INSTALL_SCRIPTS_DIR/install-dotfiles"

# 3. Rebase the dynamic island bar on the installed Omarchy bar. The
# post-update hook does this on `omarchy update`; setup covers fresh installs
# and updates done through pacman/AUR helpers.
echo "=== Refreshing the dynamic island bar ==="
REBUILD="$DOTFILES_DIR/omarchy/.config/omarchy/plugins/romanhan.bar/rebuild"
if [ -x "$REBUILD" ]; then
  "$REBUILD" || echo "Warning: the island patch did not apply; existing bar left untouched."
else
  echo "Warning: $REBUILD not found, skipping."
fi

# 4. Restart the shell so the new bar layout and linked QML load immediately.
if command -v hyprctl >/dev/null 2>&1 && hyprctl version >/dev/null 2>&1; then
  echo "=== Restarting the Omarchy shell ==="
  omarchy restart shell || true
else
  echo "Restart the shell to apply UI changes: omarchy restart shell"
fi

echo "=== Setup complete ==="
if [ "$app_status" -ne 0 ]; then
  echo "Some app installers failed; see the summary above." >&2
  exit 1
fi
