#!/bin/bash

font_dir="$HOME/.local/share/fonts"
font_url="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/CascadiaCode/Regular/complete/Caskaydia%20Cove%20Nerd%20Font%20Complete%20Mono%20Regular.otf"

if ! fc-list | grep -q Caskaydia; then
    mkdir -p "$font_dir"
    wget "$font_url" -P "$font_dir"
    fc-cache -v
fi
