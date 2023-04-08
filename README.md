# unterwegi's dot files

This repository aims to get my own environment up and running as automatically as possible, powered by [chezmoi](https://www.chezmoi.io/).

The setup scripts are aware of the following Linux flavors:

- [Arch](https://archlinux.org/)
- [Debian](https://www.debian.org/)
- [EndeavourOS](https://endeavouros.com/)
- [Ubuntu](https://ubuntu.com/) (Mainly inside a WSL2 setup)

## Bootstrap

Install [chezmoi](https://www.chezmoi.io/install/)

```bash
chezmoi init --apply unterwegi
```

### One Liner

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply unterwegi
```

## Software needed for my setup

The following packages are automatically installed when the chezmoi config setting "installPackages" is enabled.

- git
- npm
- tmux
- python + python-pip

Arch exclusive:

- alacritty

## Shell Setup (fish)

My setup uses [fish](https://fishshell.com/) by default. To disable that, disable the chezmoi config setting "useFish".

The following fish plugins get installed (via [fisher](https://github.com/jorgebucaran/fisher)):

- [jorgebucaran/fisher](https://github.com/jorgebucaran/fisher)
- [nickeb96/puffer-fish](https://github.com/nickeb96/puffer-fish)
- [ilancosman/tide@v5](https://github.com/IlanCosman/tide)

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

See [aqua.yml.tmpl](private_dot_config/aqua.yaml) for reference.

Mend Renovate checks for updates on these packages every Monday. See [renovate.json](renovate.json)

## Terminal Color Scheme Setup

Based on [Nightfox.nvim](https://github.com/EdenEast/nightfox.nvim).

See [alacritty.yml](private_dot_config/alacritty/alacritty.yml) for reference.
