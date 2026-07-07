#!/usr/bin/env bash
set -euo pipefail

DOOM_BIN="${HOME}/.emacs.d/bin/doom"
if ! command -v doom >/dev/null 2>&1 && [ ! -x "${DOOM_BIN}" ]; then
    echo "==> Skipping doom sync (doom emacs not installed)"
    exit 0
fi

DOOM_CMD="$(command -v doom || echo "${DOOM_BIN}")"

echo "==> Syncing and upgrading Doom Emacs..."
if [ "${DRY_RUN}" -eq 1 ]; then
    echo "  would run: ${DOOM_CMD} sync && ${DOOM_CMD} upgrade"
else
    "${DOOM_CMD}" sync
    "${DOOM_CMD}" upgrade
fi
