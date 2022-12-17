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

## Software to install before applying

- git
- tmux
- [Optional] alacritty

## Software managed through [aqua](https://github.com/aquaproj/aqua)

- [chezmoi](https://github.com/twpayne/chezmoi)
- [starship](https://github.com/starship/starship)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fd](https://github.com/sharkdp/fd)
- [exa](https://github.com/ogham/exa)
- [neovim](https://github.com/neovim/neovim)
- [Github CLI](https://github.com/cli/cli)
- [direnv](https://github.com/direnv/direnv)
- [yq](https://github.com/mikefarah/yq)
- [kubectl](https://github.com/kubernetes/kubectl)
- [kustomize](https://github.com/kubernetes-sigs/kustomize)
- [helm](https://github.com/helm/helm)
- [k9s](https://github.com/derailed/k9s)
- [navi](https://github.com/denisidoro/navi)
- [Optional] [rclone](https://github.com/rclone/rclone)

See [aqua.yml.tmpl](private_dot_config/aqua.yaml.tmpl) for reference.

## Terminal Color Scheme Setup

Based on [Nightfox.nvim](https://github.com/EdenEast/nightfox.nvim).

See [alacritty.yml](private_dot_config/alacritty/alacritty.yml) for reference.
