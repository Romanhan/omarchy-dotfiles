# omarchy-dotfiles
Personal settings for omarchy quattro

![omarchy quattro](screenshots/screenshot-2026-08-28_13-09-53.png)

## Setup

```sh
git clone git@github.com:Romanhan/omarchy-dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

`setup.sh` runs every `install-scripts/install-*` script. `install-dotfiles`
installs `stow` and links these packages into `~/.config`:

```
bash  kitty  hypr  superfile  vscode
```

Finish with `omarchy restart shell`.

## Notes

- **`monitors.lua`** is stowed, but Omarchy's monitor-scaling shortcut rewrites
  it with `sed -i`. The keybinding wrapper runs
  `install-scripts/sync-monitors` afterwards, which copies the live file back
  into the repo and swaps in the symlink with one atomic rename.
- **Large upstream themes** (`blackgold`, `harbordark`, `dracula`) are cloned
  by `install-scripts/install-themes` into `~/.config/omarchy/themes`.
- **Flea** is installed from Omarchy's repo. Run `flea --default` once if it is
  not already the default file manager. If it replaced the `bindings.lua`
  symlink with a regular file, run `stow --adopt hypr` and review
  `git diff hypr/` before committing.
