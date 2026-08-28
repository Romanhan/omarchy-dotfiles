-- Change the default Omarchy look'n'feel.

-- https://wiki.hypr.land/Configuring/Basics/Variables/#general
hl.config({
  general = {
    -- No gaps between windows or borders.
    gaps_in = 2,
    gaps_out = 2,
    border_size = 2,

    -- Change to niri-like side-scrolling layout.
    --     layout = "scrolling",
  },
})

-- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
hl.config({
  decoration = {
    -- Use round window corners.
    rounding = 20,
    --
    -- Dim unfocused windows (0.0 = no dim, 1.0 = fully dimmed).
    dim_inactive = true,
    dim_strength = 0.25,

    blur = {
      enabled = true,
      size = 4,
      passes = 1,
      ignore_opacity = true,    -- blur ignores the window's own opacity
      new_optimizations = true, -- big perf win; leave on
      xray = false,             -- floating windows ignore tiled windows' blur
      vibrancy = 0.17,
      popups = true,            -- blur right-click menus
    },
  },
})

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
-- Keep the Omarchy style, just make everything near-instant (~0.15x speed).
hl.animation({ leaf = "global",        enabled = true, speed = 3.0,  bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 1.6,  bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 1.2,  bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 1.2,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 0.45, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 0.52, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 0.44, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 0.9,  bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 1.2,  bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 1.2,  bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 0.45, bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 0.54, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 0.42, bezier = "almostLinear" })

-- https://wiki.hypr.land/Configuring/Basics/Variables/#layout
-- hl.config({
--   layout = {
--     -- Avoid overly wide single-window layouts on wide screens.
--     single_window_aspect_ratio = { 1, 1 },
--   },
-- })

-- https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/
-- hl.config({
--   scrolling = {
--     -- See only one column per screen instead of two.
--     column_width = 0.97,
--   },
-- })
