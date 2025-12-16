# unterwegi's dot files

This repository aims to get my own environment up and running as automatically as possible, powered by [chezmoi](https://www.chezmoi.io/).

The setup scripts are aware of the following Linux flavors:

- [Arch](https://archlinux.org/)
- [Debian](https://www.debian.org/)
- [EndeavourOS](https://endeavouros.com/)
- [Fedora Workstation](https://fedoraproject.org/workstation/)
- [Ubuntu](https://ubuntu.com/) (Mainly inside a WSL2 setup)

## Bootstrap

Optionally, install [chezmoi](https://www.chezmoi.io/install/) beforehand. The `bootstrap.sh` script does it automatically if it can't find it.

```bash
./bootstrap.sh
```

## Software needed for my setup

The following packages are automatically installed when the chezmoi config setting "installPackages" is enabled.

- git
- golang
- kitty
- npm
- tmux
- python + python-pip

## Shell Setup (fish)

My setup uses [fish](https://fishshell.com/) by default. To disable that, disable the chezmoi config setting "useFish".

The following fish plugins get installed (via [fisher](https://github.com/jorgebucaran/fisher)):

- [edc/bass](https://github.com/edc/bass)
- [ilancosman/tide@v5](https://github.com/IlanCosman/tide)
- [jorgebucaran/fisher](https://github.com/jorgebucaran/fisher)
- [nickeb96/puffer-fish](https://github.com/nickeb96/puffer-fish)

## Software managed through [aqua](https://github.com/aquaproj/aqua)

- [AWS CLI](https://github.com/aws/aws-cli/tree/v2)
- [Github CLI](https://github.com/cli/cli)
- [Gitlab CLI](https://gitlab.com/gitlab-org/cli)
- [chezmoi](https://github.com/twpayne/chezmoi)
- [devpod](https://github.com/loft-sh/devpod)
- [direnv](https://github.com/direnv/direnv)
- [dive](https://github.com/wagoodman/dive)
- [exa](https://github.com/ogham/exa)
- [fd](https://github.com/sharkdp/fd)
- [fzf](https://github.com/junegunn/fzf)
- [goimports](https://pkg.go.dev/golang.org/x/tools/cmd/goimports)
- [golangci-lint](https://github.com/golangci/golangci-lint)
- [grpcurl](https://github.com/fullstorydev/grpcurl)
- [helm](https://github.com/helm/helm)
- [jwt-cli](https://github.com/mike-engel/jwt-cli)
- [k9s](https://github.com/derailed/k9s)
- [kubectl](https://github.com/kubernetes/kubectl)
- [kustomize](https://github.com/kubernetes-sigs/kustomize)
- [lsd](https://github.com/lsd-rs/lsd)
- [minikube](https://github.com/kubernetes/minikube)
- [modd](https://github.com/cortesi/modd)
- [navi](https://github.com/denisidoro/navi)
- [neovim](https://github.com/neovim/neovim)
- [rclone](https://github.com/rclone/rclone)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [ruff](https://github.com/astral-sh/ruff)
- [starship](https://github.com/starship/starship)
- [stern](https://github.com/stern/stern)
- [tree-sitter](https://github.com/tree-sitter/tree-sitter)
- [vault](https://github.com/hashicorp/vault)
- [yq](https://github.com/mikefarah/yq)

See [aqua.yml](private_dot_config/aqua.yaml) for reference.

Mend Renovate checks for updates on these packages every Monday. See [renovate.json](renovate.json)

## Terminal Color Scheme Setup

Based on [Nightfox.nvim](https://github.com/EdenEast/nightfox.nvim).

See [kitty.conf](private_dot_config/kitty/kitty.conf) for reference.
