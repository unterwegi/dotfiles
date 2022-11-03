i#!/bin/bash

set -eufo pipefail

echo -e "\033[0;32m>>>>> Begin Setting Up Neovim <<<<<\033[0m"
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
echo -e "\033[0;32m>>>>> Finish Setting Up Neovim <<<<<\033[0m"
