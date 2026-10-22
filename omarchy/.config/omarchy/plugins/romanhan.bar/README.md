# Dynamic island bar

Roman's custom bar plugin, cloned from `omarchy.bar`. The bar engine and tray
are generated from the installed Omarchy files so upstream fixes flow through
on the next update.

## Generated files

Do not edit these by hand:

- `Bar.qml` — stock `Bar.qml` + `island.patch`
- `BarModel.js` — stock
- `../romanhan.tray/Tray.qml` — stock `Tray.qml` + `tray.patch`
- `../romanhan.tray/TrayModel.js` — stock

Run `./rebuild` after an Omarchy update. The post-update hook does this
automatically for `omarchy update`. If a patch no longer applies, `rebuild`
leaves the existing working files untouched and exits nonzero.

## Custom files

- `widgets/Indicators.qml` and `indicators/` — compact active-only indicator
  row, including the Dictation indicator.
- `widgets/Workspaces.qml` — fixed four-slot workspace row.
- `../../bar/modules/island-reveal.qml` — the reveal chevron.
- `shell.json` — bar layout, including the custom Sources for the two widgets
  above.

Widgets named `omarchy.*` come from the installed Omarchy shell and are updated
with it. Widgets named `romanhan.*` are separate custom plugins. Only the files
listed under **Generated files** are rebuilt from stock.
