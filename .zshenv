#################################################
#                     ENV                       #
#################################################

PWD="$(pwd)"

export TERM=xterm-24bit

# Add rust binaries and local bin folder
export PATH="$PWD/projects/go/bin:$PWD/.cargo/bin:$PWD/.bin/:$PWD/.npm-packages/bin/:$PATH"

export EDITOR=nvim
export VISUAL=nvim

export LPASS_PINENTRY="$(which pinentry)"
export LPASS_AGENT_TIMEOUT="10800" # 3h

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
# export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# Python virtualenv-wrapper integration
export WORKON_HOME=$HOME/.virtualenvs

# GPG config
export GPG_TTY=$(tty)
VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source virtualenvwrapper.sh

if [ "$machine" =  "Mac" ]; then
    export PATH=$PATH:/usr/local/bin
    alias ctags="`brew --prefix`/bin/ctags"
fi

[ -f ~/.local.profile ] && source ~/.local.profile
[ -f ~/.aliases ] && source ~/.aliases
