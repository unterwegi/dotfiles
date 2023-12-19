set -gx GOENV_ROOT $HOME/.goenv
fish_add_path -g $GOENV_ROOT/bin

if command -q goenv
    if status is-interactive
        # must be done before the actual init call, so that goenv is used before the system go binary
        fish_add_path -g $GOENV_ROOT/shims
        goenv init - | source
    end
end
