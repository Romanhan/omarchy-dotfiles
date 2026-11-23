-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Omarchy's bootstrap keeps path setup out of this user config.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- Disable all Omarchy default bindings. Add your own in hypr/bindings.lua.
-- omarchy_default_bindings = false
--
-- Or disable only bindings for Omarchy's preinstalled apps/web apps while
-- keeping core window-manager bindings:
-- omarchy_preinstalled_bindings = false

-- Load Omarchy defaults.
require("default.hypr.omarchy")

-- Put your personal overrides in these files. They're loaded after Omarchy's
-- defaults so package updates can improve the defaults without rewriting your
-- ~/.config/hypr files.
require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.autostart")

-- Toggle config flags dynamically.
require("default.hypr.toggles")

-- Add any other personal Hyprland configuration below.
-- o.window("qemu", { workspace = "5" })
require("hypr.omacast")

-- Cursor theme + size.
-- The theme string is used as a DIRECTORY name under /usr/share/icons/
-- (Hyprland builds "<dir>/<theme>/cursors"), so it must be "breeze_cursors"
-- -- NOT the display name "Breeze Dark" from index.theme's Name= field.
-- A name with no matching directory fails silently and falls back to
-- /usr/share/icons/default (Inherits=Adwaita), which is why the cursor
-- never appeared to change.
hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "breeze_cursors")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "breeze_cursors")

hl.config({
  cursor = {
    -- No hyprcursor themes are installed, so this can only ever fail and
    -- fall back to XCursor. Go straight to XCursor.
    enable_hyprcursor = false,
    -- Let GSettings (org.gnome.desktop.interface) stay the source of truth
    -- so Hyprland and GTK can never disagree about the cursor.
    sync_gsettings_theme = true,
  },
})
