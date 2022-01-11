#!/bin/bash

font_dir="$HOME/.local/share/fonts"

mkdir -p "$font_dir"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip -P "$font_dir"

cd "$font_dir" || exit

unzip CascadiaCode.zip
rm CascadiaCode.zip
fc-cache -v
