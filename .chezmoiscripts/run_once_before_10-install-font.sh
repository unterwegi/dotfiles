#!/bin/bash

font_dir="$HOME/.local/share/fonts"
font_url="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/CascadiaCode/Regular/CaskaydiaCoveNerdFont-Regular.ttf"

if ! fc-list | grep -q Caskaydia; then
    mkdir -p "$font_dir"
    wget "$font_url" -P "$font_dir"
    fc-cache -v
fi
