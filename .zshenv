#################################################
#                     ALIASES                   #
#################################################
alias vim=nvim
alias vi=nvim

#################################################
#                     ENV                       #
#################################################

# Add rust binaries and local bin folder
export PATH="$(pwd)/.cargo/bin:$(pwd)/.bin/:$(pwd)/.npm-packages/bin/:$PATH"

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

# GO config
export GOPATH=$HOME/projects/go

# Rust
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# Python virtualenv-wrapper integration
export WORKON_HOME=$HOME/.virtualenvs

VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
if [ "$machine" =  "Linux" ]; then
    source virtualenvwrapper.sh
else
    source ~/Library/Python/2.7/bin/virtualenvwrapper.sh
fi

if [ "$machine" =  "Mac" ]; then
    export PATH=$PATH:/usr/local/bin
    alias ctags="`brew --prefix`/bin/ctags"
fi

[ -f ~/.local.profile ] && source ~/.local.profile
