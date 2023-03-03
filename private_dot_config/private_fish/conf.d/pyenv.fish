if command -q pyenv
    set -gx PYENV_ROOT $HOME/.pyenv
    fish_add_path -g $PYENV_ROOT/bin

    if status is-interactive
        pyenv init - | source
    end
end
