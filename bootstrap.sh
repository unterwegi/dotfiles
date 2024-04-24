#!/bin/sh
set -e

if command -v chezmoi >/dev/null; then
  chezmoi init --apply unterwegi
else
  # downloads and installs chezmoi into .local/bin
  sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply unterwegi
fi
