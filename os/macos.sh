PACKAGES=(
    zsh
    tmux
    neovim
    node
    font-hack-nerd-font
)

pkg_install() {
    brew install "${PACKAGES[@]}"
}
