-- Written by `omacast setup hyprland`. Safe to edit; rerunning setup keeps it.
-- Alt+Space reaches the plugin's global shortcut directly, so no process
-- starts per keypress. Omarchy's own menu stays on Super+Space.
o.bind("ALT + SPACE", "omacast launcher", hl.dsp.global("omacast:toggle"), { submap_universal = true })
-- While the launcher is open, the plugin puts Hyprland in this submap so Super+J/K
-- (and every other Super key Hyprland would grab) reach omacast as arrow keys.
-- omacast's own hotkeys are submap_universal so they still work there.
hl.define_submap("omacast", function()
  hl.bind("SUPER + F24", hl.dsp.no_op()) -- a submap needs one bind to exist
end)
-- Blur behind the launcher; it only shows under Omarchy's Glassy windows,
-- where the card is see-through.
hl.layer_rule({ match = { namespace = "^omacast$" }, blur = true, ignore_alpha = 0.3 })
