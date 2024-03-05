set -gx PYENV_ROOT $HOME/.pyenv
test -d $PYENV_ROOT/bin && fish_add_path -g $PYENV_ROOT/bin

if command -q pyenv && status is-interactive
    pyenv init - | source
end
