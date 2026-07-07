PACKAGES=(
    zsh
    tmux
    neovim
    nodejs
    npm
)

pkg_install() {
    sudo apt-get update
    sudo apt-get install -y "${PACKAGES[@]}"
}
