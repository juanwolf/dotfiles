#!/usr/bin/env bash
set -euo pipefail

if ! command -v nvim >/dev/null 2>&1; then
    echo "==> Skipping nvim plugin install (nvim not installed)"
    exit 0
fi

echo "==> Installing/updating nvim plugins (lazy.nvim)..."
if [ "${DRY_RUN}" -eq 1 ]; then
    echo "  would run: nvim --headless '+Lazy! sync' +qa"
else
    nvim --headless '+Lazy! sync' +qa
fi
