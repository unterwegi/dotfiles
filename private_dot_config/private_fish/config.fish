# set up my EDITOR and VISUAL depending on whats available
if command -q nvim
  set -gx EDITOR nvim
  set -gx VISUAL nvim
else if command -q vim
  set -gx EDITOR vim
  set -gx VISUAL vim
else
  set -gx EDITOR vi
  set -gx VISUAL vi
end

# Tell aqua to use my config inside my home
set -gx AQUA_GLOBAL_CONFIG $HOME/.config/aqua.yaml

# Launch direnv
if command -q direnv
  direnv hook fish | source
end

# always start tmux in interactive shells
if status --is-interactive
and command -q tmux
and not set -q TMUX
    exec tmux
end
