# Tailscale Omarchy Widget

Roman's fork of `omarchy.tailscale`, cloned so the panel grows out of the
dynamic island pill. The panel, service, and model are stock r7314; the only
adaptation is in `Panel.qml` — the local `../../ui/KeyboardPanel.qml` builds
its content eagerly, so the `PanelKeyCatcher` is a plain child, `focusTarget`
points at it, the card height comes from `column.implicitHeight`, and the
root's helpers reach the content ids directly (file-scoped) instead of through
`panel.loadedContent`. The island morph itself lives in that shared
KeyboardPanel.

Stock features:

- Shows Tailscale connection state in the bar
- Left click opens a keyboard-friendly panel
- Right click toggles Tailscale on/off
- Switch between available Tailscale connections when multiple are available
- Browse and search machines from `tailscale status --json` (virtualized list
  for large tailnets)
- Copy a machine's Tailscale IP, host name, or DNS name
- Send files to a machine with Taildrop, when the tailnet allows file sharing

## Keyboard shortcuts

Inside the panel:

- `j` / `k` or arrows: move cursor
- `enter` / `space`: activate current row
- `c`: copy selected peer IP
- `n`: copy selected peer name
- `d`: copy selected peer DNS name
- `s`: send files to selected peer
- `t`: toggle Tailscale
- `r`: refresh status
- `esc`: close

## Requirements

- `tailscale` CLI on `PATH`
- `wl-copy` for clipboard copy actions
- Taildrop enabled for the tailnet, to send files

## Receiving files

Incoming Taildrop files are saved to `~/Downloads` by the
`omarchy-tailscale-receive` service, which announces each one with a
notification (an image preview when the file is an image, and a click to open
it). The Tailscale service install enables it; `omarchy tailscale receive`
runs the same loop by hand.

## Icon

Renders the Tailscale mark natively as a theme-colored 3×3 dot grid, matching the official SVG silhouette while avoiding tiny-SVG rendering quirks in the bar.

## Add to the bar

This widget ships as first-party plugin `omarchy.tailscale`. Add it with `omarchy plugin enable omarchy.tailscale`, then place it with `omarchy bar move omarchy.tailscale` if desired.
