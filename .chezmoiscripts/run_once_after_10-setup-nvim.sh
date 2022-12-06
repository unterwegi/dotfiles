#!/bin/bash

set -eufo pipefail

echo -e "\033[0;32m>>>>> Begin Setting Up Neovim <<<<<\033[0m"
packer_dir="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
mkdir -p "$packer_dir"
test -d "$packer_dir" || git clone --depth 1 https://github.com/wbthomason/packer.nvim "$packer_dir"
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
echo -e "\033[0;32m>>>>> Finish Setting Up Neovim <<<<<\033[0m"
