set -gx GOENV_ROOT $HOME/.goenv
fish_add_path -g $GOENV_ROOT/bin

if command -q goenv
    if status is-interactive
        goenv init - | source
        fish_add_path -g $GOROOT/bin
        fish_add_path -ag $GOPATH/bin
    end
end
