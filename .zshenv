#################################################
#                     ALIASES                   #
#################################################
alias vim=nvim
alias vi=nvim

#################################################
#                     ENV                       #
#################################################

# Add rust binaries and local bin folder
export PATH="$(pwd)/.cargo/bin:$(pwd)/.bin/:$PATH"

export EDITOR=nvim
export VISUAL=nvim

unameOut="$(uname -s)"

case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

# Set GOPATH
export GOPATH=$HOME/projects/go

# Python virtualenv-wrapper integration
export WORKON_HOME=$HOME/.virtualenvs

VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
if [ "$machine" =  "Linux" ]; then
    source virtualenvwrapper.sh
else
    source ~/Library/Python/2.7/bin/virtualenvwrapper.sh
fi

if [ "$machine" =  "Mac" ]; then
    alias ctags="`brew --prefix`/bin/ctags"
fi

[ -f ~/.local.profile ] && source ~/.local.profile
