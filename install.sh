#!/usr/bin/env bash
# Install the dotfiles in your home directory.
#
# Options:
#   -f            Back up any real (non-symlink) file/dir already at the
#                 target path, then replace it with the dotfiles symlink.
#   -n, --dry-run Print what would happen without changing anything.

set -euo pipefail

cd "$(dirname "${BASH_SOURCE}")"
DOTFILES_DIR="$(pwd)"

FORCE_MODE=0
DRY_RUN=0

usage() {
    cat <<EOF
Usage: $0 [-f] [-n|--dry-run]
EOF
}

while [ $# -gt 0 ]; do
    case "$1" in
        -f) FORCE_MODE=1 ;;
        -n|--dry-run) DRY_RUN=1 ;;
        -h|--help) usage; exit 0 ;;
        *) echo "Unknown option: $1" >&2; usage; exit 1 ;;
    esac
    shift
done

# Single source of truth for what gets linked where: "source relative to
# this repo:target relative to \$HOME". Used both to create links and
# (implicitly) to know what a full uninstall would need to remove.
LINKS=(
    ".tmux:.tmux"
    ".tmux.conf:.tmux.conf"
    ".vim:.vim"
    ".vimrc:.vimrc"
    ".zshrc:.zshrc"
    ".zshenv:.zshenv"
    ".oh-my-zsh:.oh-my-zsh"
    ".thymerc:.thymerc"
    ".npmrc:.npmrc"
    ".spacemacs:.spacemacs"
    ".xterm-24bit.terminfo:.xterm-24bit.terminfo"
    ".aliases:.aliases"
    ".config/nvim:.config/nvim"
    ".config/termite:.config/termite"
    ".config/i3:.config/i3"
    ".config/systemd:.config/systemd"
    ".config/doom:.config/doom"
    ".config/gomodoro:.config/gomodoro"
    ".config/claude/agents:.claude/agents"
    ".config/claude/skills:.claude/skills"
    ".config/claude/settings.json:.claude/settings.json"
)

BACKUP_DIR="${HOME}/.dotfiles_backup_$(date +%Y%m%d%H%M%S)"

detect_os() {
    case "$(uname -s)" in
        Darwin) echo "macos" ;;
        Linux)
            if [ -r /etc/os-release ]; then
                # shellcheck disable=SC1091
                . /etc/os-release
                case "${ID:-}" in
                    arch) echo "arch" ;;
                    ubuntu|debian) echo "debian" ;;
                    *) echo "${ID:-unknown}" ;;
                esac
            else
                echo "unknown"
            fi
            ;;
        *) echo "unknown" ;;
    esac
}

link_one() {
    local src="${DOTFILES_DIR}/$1"
    local dest="${HOME}/$2"

    if [ -L "${dest}" ]; then
        if [ "$(readlink "${dest}")" = "${src}" ]; then
            echo "  [skip] ${dest} already linked"
            return
        fi
        if [ "${DRY_RUN}" -eq 1 ]; then
            echo "  [relink] ${dest} -> ${src}"
            return
        fi
        rm "${dest}"
    elif [ -e "${dest}" ]; then
        if [ "${FORCE_MODE}" -ne 1 ]; then
            echo "  [conflict] ${dest} exists and isn't a symlink (rerun with -f to back it up and replace)" >&2
            return
        fi
        if [ "${DRY_RUN}" -eq 1 ]; then
            echo "  [backup+link] ${dest} -> ${BACKUP_DIR}/$2, then link to ${src}"
            return
        fi
        mkdir -p "$(dirname "${BACKUP_DIR}/$2")"
        mv "${dest}" "${BACKUP_DIR}/$2"
    elif [ "${DRY_RUN}" -eq 1 ]; then
        echo "  [link] ${dest} -> ${src}"
        return
    fi

    mkdir -p "$(dirname "${dest}")"
    ln -s "${src}" "${dest}"
    echo "  [linked] ${dest} -> ${src}"
}

create_symbolic_links() {
    echo "==> Linking dotfiles..."
    for pair in "${LINKS[@]}"; do
        link_one "${pair%%:*}" "${pair#*:}"
    done
}

run_hooks() {
    echo "==> Running post-install hooks..."
    export DOTFILES_DIR DRY_RUN OS_NAME
    for hook in "${DOTFILES_DIR}"/hooks.d/*.sh; do
        [ -x "${hook}" ] || continue
        echo "--- ${hook##*/} ---"
        "${hook}"
    done
}

OS_NAME="$(detect_os)"
echo "Detected OS: ${OS_NAME}"
if [ "${FORCE_MODE}" -eq 1 ] && [ "${DRY_RUN}" -ne 1 ]; then
    echo "Existing real files/dirs will be backed up to ${BACKUP_DIR}"
fi

create_symbolic_links
run_hooks

echo "Done."
