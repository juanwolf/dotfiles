#!/bin/bash
source ~/.zshenv

rm -R ~/.virtualenvs/nvim*
mkvirtualenv nvim -p python3
mkvirtualenv nvim2 -p python2

workon nvim
pip install neovim
deactivate

workon nvim2
pip install neovim
deactivate
