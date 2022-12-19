set -U fish_greeting

fish_add_path -a -P $HOME/bin $HOME/.local/bin
# aqua managed binaries should be used first
fish_add_path -P $HOME/.local/share/aquaproj-aqua/bin

# set up my EDITOR and VISUAL depending on whats available
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

# Launch Starship prompt
if type -q starship
  starship init fish | source
end

# Launch direnv
if type -q direnv
  direnv hook fish | source
end

# always start tmux in interactive shells
if status --is-interactive
and type -q tmux
and not set -q TMUX
    exec tmux
end
