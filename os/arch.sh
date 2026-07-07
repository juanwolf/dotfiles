PACKAGES=(
    zsh
    tmux
    neovim
    nodejs
    npm
    termite
    i3-gaps
    nerd-fonts-complete
)

pkg_install() {
    sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"
}
