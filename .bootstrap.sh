#!/bin/bash

font_dir="$HOME/.local/share/fonts"

mkdir -p "$font_dir"
wget https://github.com/ryanoasis/nerd-fonts/raw/v2.1.0/patched-fonts/CascadiaCode/complete/Caskaydia%20Cove%20Nerd%20Font%20Complete%20Mono.ttf -P "$font_dir"
fc-cache -v
