#!/usr/bin/env bash
set -euo pipefail

echo "==> Initializing git submodules (oh-my-zsh, tpm)..."
if [ "${DRY_RUN}" -eq 1 ]; then
    echo "  would run: git submodule update --init --recursive"
else
    git -C "${DOTFILES_DIR}" submodule update --init --recursive
fi
