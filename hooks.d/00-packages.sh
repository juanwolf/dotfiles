#!/usr/bin/env bash
set -euo pipefail

source "${DOTFILES_DIR}/os/${OS_NAME}.sh"

echo "==> Installing packages for ${OS_NAME}..."
if [ "${DRY_RUN}" -eq 1 ]; then
    printf '  would install: %s\n' "${PACKAGES[*]}"
else
    pkg_install
fi
