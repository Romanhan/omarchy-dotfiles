#!/bin/bash
# Only show icon if tailscale is up
if tailscale status >/dev/null 2>&1; then
    printf '{"text": "󱗼", "class": "tailscale-up"}\n'
else
    printf ""  # empty → module hidden
fi
