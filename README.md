# unterwegi's dot files

## Bootstrap

Add SSH key in [Github Key settings](https://github.com/settings/keys)

Install [chezmoi](https://www.chezmoi.io/install/)

```bash
chezmoi init --ssh --apply unterwegi
```

### One Liner

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --ssh --apply unterwegi
```

## Necessary software to install before applying

* git
* tmux
* [ripgrep](https://github.com/BurntSushi/ripgrep)
* [neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)

## Optional software

* rclone (for Google Drive sync)
* alacritty

## Terminal Color Scheme Setup

Based on [Tomorrow Night](https://github.com/ChrisKempson/Tomorrow-Theme#tomorrow-night).

See [alacritty.yml](private_dot_config/alacritty/alacritty.yml) for reference.
