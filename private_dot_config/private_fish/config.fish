set -U fish_greeting

fish_add_path -a -P $HOME/bin $HOME/.local/bin
# aqua managed binaries should be used first
fish_add_path -P $HOME/.local/share/aquaproj-aqua/bin

if type -q nvim
  set -gx EDITOR nvim
  set -gx VISUAL nvim
else if type -q vim
  set -gx EDITOR vim
  set -gx VISUAL vim
else
  set -gx EDITOR vi
  set -gx VISUAL vi
end

# Tell aqua to use my config inside my home
set -gx AQUA_GLOBAL_CONFIG $HOME/.config/aqua.yaml
