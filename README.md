# omarchy-dotfiles
Personal settings for omarchy quattro

![omarchy quattro](screenshots/screenshot-2026-08-28_13-09-53.png)

## Setup

```sh
git clone git@github.com:Romanhan/omarchy-dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

`setup.sh` runs the app installers, links the dotfiles, rebuilds the dynamic
island bar, and restarts the Omarchy shell when a Hyprland session is available.

### App installers

Every app has its own `install-scripts/install-*` file. `install-apps` runs them
one by one, keeps going when one fails, and prints a summary of what did not
install:

```sh
install-scripts/install-apps
```

It installs: brave, flea, kitty, superfile, Code - OSS, stow, the large themes,
and trash-cli. `flea --default` is applied automatically. The Flea installer
replaces the old AUR `flea-bin` package, and the Code - OSS installer drops
`visual-studio-code-bin` if it is present. If an app installer fails, the rest
still run, the failures are listed, and `setup.sh` continues linking dotfiles
before exiting nonzero.

### Dotfiles

`install-dotfiles` links these packages into your home (`~/.config`, plus
`~/.bashrc`):

```text
bash  kitty  hypr  superfile  omarchy  code-oss
```

A fresh Omarchy home is seeded from `/etc/skel`, so those files already exist.
The linker copies each conflicting file to
`~/.local/state/dotfiles/backups/<timestamp>/` first, then swaps in the symlink
with one atomic rename. It never removes a config file without a backup, and
Hyprland never sees a missing `hyprland.lua`.

## Notes

- **Why `sync-shell-json` exists**: Omarchy rewrites
  `~/.config/omarchy/shell.json` with an atomic save (a new file replaces the
  old one). A stow symlink would silently become a regular file on the first
  bar edit, so the repo would stop tracking your layout. Instead the repo keeps
  a snapshot:
  - `install-scripts/sync-shell-json` copies the live file into the repo after
    you change the bar.
  - `install-scripts/sync-shell-json --push` seeds a fresh machine from the
    snapshot.
  Without it, a fresh install would get Omarchy's stock bar instead of this
  layout, plugin list, and disabled-plugin settings.

- **`monitors.lua` is not in this repo.** Monitor scaling is left to Omarchy's
  stock file and the built-in scaling controls.

- **Dynamic island bar** is generated from the installed stock bar plus
  `island.patch`. After an Omarchy update run
  `omarchy/.config/omarchy/plugins/romanhan.bar/rebuild` (the post-update hook
  does this automatically for `omarchy update`).

- **Large upstream themes** (`blackgold`, `harbordark`, `dracula`) are cloned
  by `install-scripts/install-themes` into
  `~/.config/omarchy/themes` and ignored by git. The small custom themes
  (`aether`, `redbull`) are tracked.

- **Code - OSS** uses Arch's `code` package and keeps settings at
  `~/.config/Code - OSS/User/settings.json`, not the proprietary VS Code path.

- **Flea** is installed from Omarchy's repo and set as the default file
  manager. Its Hyprland bindings are already in `hypr/bindings.lua`.
