#################################################
#                     ENV                       #
#################################################

PWD="$(pwd)"

# GO config
export GOPATH=$HOME/projects/go

export TERM=xterm-256color
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY

# Add rust binaries and local bin folder
export PATH="$GOPATH/bin:$PWD/.cargo/bin:$PWD/.bin/:$PWD/.npm-packages/bin/:$PATH"

export EDITOR=nvim
export VISUAL=nvim

unameOut="$(uname -s)"

case "${unameOut}" in
    Linux*) machine=Linux ;;
    Darwin*) machine=Mac ;;
    CYGWIN*) machine=Cygwin ;;
    MINGW*) machine=MinGw ;;
    *) machine="UNKNOWN:${unameOut}" ;;
esac

# GPG config
export GPG_TTY=$(tty)
if [ "$machine" = "Mac" ]; then
    export PATH="$PATH:/usr/local/bin:/opt/homebrew/bin"
    alias ctags="$(brew --prefix)/bin/ctags"
fi

# Rust
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

[ -f ~/.local.profile ] && source ~/.local.profile
[ -f ~/.aliases ] && source ~/.aliases
