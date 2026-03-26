#!/bin/bash

check_updates() {
  # Check for official repo updates (syncs to temp DB, no sudo needed)
  pacman_updates=$(checkupdates 2>/dev/null | wc -l)
  
  # Check for AUR updates
  aur_updates=$(yay -Qua 2>/dev/null | wc -l)
  
  total_updates=$((pacman_updates + aur_updates))
 
  if [[ $total_updates -gt 0 ]]; then
    echo "󰅢 $total_updates"
  else
    echo ""
  fi
}

perform_updates() {
  setsid uwsm app -- kitty --class=Omarchy --title=Omarchy -e bash -c "omarchy-show-logo; omarchy-update-perform; omarchy-show-done" &
  wait $!
  pkill -RTMIN+8 waybar
}

# Main logic
if [[ "$1" == "update" ]]; then
  perform_updates
else
  check_updates
fi
