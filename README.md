# Dotfiles

A simple collection of my unix configuration files.

## How to use it?

```
git clone --recursive https://github.com/juanwolf/dotfiles.git
./install.sh -f
```
And here you go.

**Warning**: The script will erase your previous configuration.
You can use it without the -f to not erase your existing configuration.

### Tmux

#### Default Features

* Main key: Ctrl + A
* Navigation with alt + arrows key
* Pane synchronization with Ctrl + A, Ctrl + S
* Basic theme configuration.

### Zsh

* Using oh-my-zsh
* Agnoster theme
* Mainly python, django, docker plugins enabled


### Vim

* VimPlug as plugin manager, main commands bellow:
  * :PlugClean
  * :PlugInstall
  * :PlugUpdate
* Easier navigation with Ctrl + h,j,k,l between panes
* Solarized theme
  * **Shortcut**: F6 to switch between dark/light mode
* Nerdtree
  * **Shortcut**: F3
* YouCompleteMe + custom installation (python + go + js)
  * **Important**: You need npm + nodejs to be installed for the js support.
* Syntastic
* CtrlP
* tagbar
  * **Shortcut**: F8
* Vim fugitive (Git commands) + Git Gutter, main commands:
  * :Gpull
  * :Gpush
  * :Gcommit
* Airline
* Tags with vim-tags
  * :TagsGenerate
  * Jump to definition (class, function) -> Ctrl + n
