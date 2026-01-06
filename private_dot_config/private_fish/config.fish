# disable greeting
set -g fish_greeting

# manually managed executables in PATH
fish_add_path -a -g $HOME/bin $HOME/.local/bin
# aqua managed binaries should be used first
fish_add_path -g $HOME/.local/share/aquaproj-aqua/bin

# enable my keybindings
set -g fish_key_bindings fish_user_key_bindings

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

if status is-interactive
    # Launch direnv
    if command -q direnv && not functions -q __direnv_export_eval
      direnv hook fish | source
    end

    # always start tmux in interactive shells
    if command -q tmux && not set -q TMUX
        exec tmux
    end
end
