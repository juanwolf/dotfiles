#!/usr/bin/env bash
# Install the dotfiles in your home directory

# Options:
# -f Remove the dotfiles on ~ by symlinks to these ones.

# Moving to dotfiles directory
cd "$(dirname "${BASH_SOURCE}")"

FALSE=0
TRUE=1

FORCE_MODE=$FALSE

while getopts "f" option
do
    case "${option}" in
       f) FORCE_MODE=$TRUE;;
    esac
done

function create_symbolic_link() {
    ln -s $(pwd)/.tmux ~/.tmux
    ln -s $(pwd)/.tmux.conf ~/.tmux.conf
    ln -s $(pwd)/.vim ~/.vim
    ln -s $(pwd)/.vimrc ~/.vimrc
    ln -s $(pwd)/.zshrc ~/.zshrc
    ln -s $(pwd)/.zshenv ~/.zshenv
    ln -s $(pwd)/.oh-my-zsh ~/.oh-my-zsh
    ln -s $(pwd)/.thymerc ~/.thymerc
    ln -s $(pwd)/.npmrc ~/.npmrc
    ln -s $(pwd)/.spacemacs ~/.spacemacs
    if [ ! -f ~/.config ] && [ ! -d ~/config ]; then
        if [ ! -f ~/.nvim ] && [ ! -d ~/.config/nvim ]; then
            ln -s $(pwd)/.config/nvim ~/.config/nvim
        fi
        ln -s $(pwd)/.config/termite ~/.config/termite
        ln -s $(pwd)/.config/i3 ~/.config/i3
        ln -s $(pwd)/.config/i3status ~/.config/i3status
    fi
}

function remove_dotfiles() {
    if [ -L ~/.tmux ]; then
        rm ~/.tmux
    else
        rm -R ~/.tmux
    fi

    if [ -L ~/.vim ]; then
        rm ~/.vim
    else
        rm -R ~/.vim
    fi

    rm ~/.tmux.conf
    rm ~/.vimrc
    rm ~/.zshrc
    if [ -L ~/.oh-my-zsh ]; then
        rm ~/.oh-my-zsh
    else
        rm -R ~/.oh-my-zsh
    fi
}

if [ $FORCE_MODE -eq $TRUE ]; then
    remove_dotfiles
fi

create_symbolic_link
