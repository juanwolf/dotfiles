#!/usr/bin/env bash
# Install the dotfiles in your home directory

# Options:
# -r Replace the dotfiles on ~ by these ones. (WARNING: will erase exisiting files)

# Moving to dotfiles directory
cd "$(dirname "${BASH_SOURCE}")"

FALSE=0
TRUE=1

REPLACE_MODE=$FALSE

while getopts r: option
do
    case "${option}" in
        r) REPLACE_MODE=$TRUE;;
    esac
done

function create_symbolic_link() {
    ln -s $(pwd)/.tmux ~/.tmux
    ln -s $(pwd)/.tmux.conf ~/.tmux.conf
    ln -s $(pwd)/.vim ~/.vim
    ln -s $(pwd)/.vimrc ~/.vimrc
    ln -s $(pwd)/.zshrc ~/.zshrc
    ln -s $(pwd)/.oh-my-zsh ~/.oh-my-zsh
    if [ ! -f ~/dotfiles ] && [ ! -d ~/dotfiles ]; then
        ln -s $(pwd)/dotfiles ~/dotfiles
    else
        echo "WARNING: dotfiles file/folder found in your home directory."
        echo "Symbolic link for dotfiles binary not created."
    fi
}

function replace_dotfiles() {
    rsync --exclude ".git/" \
        --exclude ".DS_Store" \
        --exclude "install.sh" \
        --exclude "README.md" \
        -avh --no-perms . ~;
}

if [ $REPLACE_MODE -eq $TRUE ]; then
    replace_dotfiles
else
    create_symbolic_link
fi

