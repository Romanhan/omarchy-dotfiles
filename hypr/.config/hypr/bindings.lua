-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Unbind defaults that conflict with custom bindings below
hl.unbind("SUPER + J")
hl.unbind("SUPER + K")
hl.unbind("SUPER + L")
hl.unbind("SUPER + T")
hl.unbind("SUPER + S")
hl.unbind("SUPER + SLASH")
hl.unbind("SUPER + CTRL + C")
hl.unbind("SUPER + ALT + J")
hl.unbind("SUPER + ALT + K")
hl.unbind("SUPER + ALT + P")
hl.unbind("SUPER + SHIFT + B")
hl.unbind("SUPER + SHIFT + N")
hl.unbind("SUPER + SHIFT + D")
hl.unbind("SUPER + SHIFT + SLASH")

-- Displaced defaults (rebound to new keys)
o.bind("SUPER + ALT + L", "Toggle workspace layout", "omarchy-hyprland-workspace-layout-toggle")
o.bind("SUPER + ALT + J", "Toggle split", hl.dsp.layout("togglesplit"))
o.bind("SUPER + ALT + T", "Toggle floating", hl.dsp.window.float({ action = "toggle" }))
o.bind("SUPER + ALT + S", "Toggle scratchpad", hl.dsp.workspace.toggle_special("scratchpad"))
o.bind("SUPER + ALT + C", "Capture menu", "omarchy-menu toggle capture")

-- Custom keybindings
o.bind("SUPER + ALT + K", "Keybindings", "omarchy-menu-keybindings")
o.bind("SUPER + ALT + P", "Power profile", "omarchy-menu power")
o.bind("SUPER + CTRL + 0", "Reveal hidden bar widgets", "omarchy-shell romanhan.bar toggleReveal")

-- Applications
o.bind("SUPER + Q", "Close window", hl.dsp.window.close())
o.bind("SUPER + T", "Terminal", "omarchy-launch-terminal")
o.bind("SUPER + Y", "Yazi", "uwsm-app -- xdg-terminal-exec --dir=\"$(omarchy-cmd-terminal-cwd)\" -e yazi")
o.bind("SUPER + S", "Superfile", "uwsm-app -- xdg-terminal-exec --dir=\"$(omarchy-cmd-terminal-cwd)\" -e spf")
o.bind("SUPER + E", "File manager", { omarchy = "nautilus" })
o.bind("SUPER + B", "Browser", { omarchy = "browser" })
o.bind("SUPER + ALT + B", "Browser (private)", { omarchy = "browser --private" })
o.bind("SUPER + N", "Editor", { omarchy = "editor" })
o.bind("SUPER + SHIFT + O", "Obsidian", { launch = "obsidian", focus = "^obsidian$" })
o.bind("SUPER + SLASH", "Passwords", "uwsm app -- bitwarden-desktop")

-- Webapps
o.bind("SUPER + CTRL + G", "GitHub", { webapp = "https://github.com" })

-- Email: override default Hey.com with Gmail
hl.unbind("SUPER + SHIFT + E")
o.bind("SUPER + SHIFT + E", "Email (Gmail)", { webapp = "https://mail.google.com" })
hl.unbind("SUPER + SHIFT + ALT + E")
o.bind("SUPER + SHIFT + ALT + E", "New email (Gmail)", { webapp = "https://mail.google.com/mail/u/0/#compose" })

-- Window management: vim-style focus
o.bind("SUPER + H", "Focus left", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + J", "Focus down", hl.dsp.focus({ direction = "d" }))
o.bind("SUPER + K", "Focus up", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + L", "Focus right", hl.dsp.focus({ direction = "r" }))

-- Window management: swap
o.bind("SUPER + SHIFT + H", "Swap left", hl.dsp.window.swap({ direction = "l" }))
o.bind("SUPER + SHIFT + J", "Swap down", hl.dsp.window.swap({ direction = "d" }))
o.bind("SUPER + SHIFT + K", "Swap up", hl.dsp.window.swap({ direction = "u" }))
o.bind("SUPER + SHIFT + L", "Swap right", hl.dsp.window.swap({ direction = "r" }))

-- Window management: resize
o.bind("SUPER + CTRL + SHIFT + H", "Resize left", hl.dsp.window.resize({ x = -45, y = 0, relative = true }))
o.bind("SUPER + CTRL + SHIFT + J", "Resize down", hl.dsp.window.resize({ x = 0, y = 45, relative = true }))
o.bind("SUPER + CTRL + SHIFT + K", "Resize up", hl.dsp.window.resize({ x = 0, y = -45, relative = true }))
o.bind("SUPER + CTRL + SHIFT + L", "Resize right", hl.dsp.window.resize({ x = 45, y = 0, relative = true }))
