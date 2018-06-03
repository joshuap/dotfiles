# ZSH Directory
if ! [ -v ZSH ]; then
  export ZSH=$HOME/.oh-my-zsh
fi

# Custom directory
ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

# Theme
ZSH_THEME="lambda"

# Plugins
plugins=(git gem osx joshuap nvm rbenv)

# OS-specific Configuration
if [ $(uname -s) = 'Darwin' ]; then
  plugins+=(brew)

  # Use nvm from Homebrew.
  export NVM_DIR=/usr/local/opt/nvm

  # Homebrew requires this path.
  export PATH="/usr/local/sbin:$PATH"
  export PATH="/usr/local/bin:$PATH"

  # Install applications to ~/Applications using homebrew cask.
  export HOMEBREW_CASK_OPTS="--appdir=~/Applications"
else
  # pbcopy/pbpaste utilities
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'
fi

alias vim=nvim

alias http="python -m http.server"

# Load oh-my-zsh (plugins finalized)
source $ZSH/oh-my-zsh.sh

# User Configuration

export EDITOR='vim'

# ~/.bin is for portable/managed executables.
export PATH=$HOME/.bin:$PATH

# ~/bin is for local executables.
export PATH=$HOME/bin:$PATH

# Global binstubs
export PATH="./bin:$PATH"

# https://gist.github.com/sj26/2600122#bonus
# Putting the following in your shell config (eg. ~/.bash_profile) will make
# Rails even faster, but will increase its memory footprint:
export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_GC_HEAP_INIT_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_FREE_MIN=500000

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Golang setup
export GOPATH=$HOME/code/go
export PATH=$PATH:$GOPATH/bin

# Hub
# See https://hub.github.com/
if hash hub 2>/dev/null; then alias git=hub; fi

# TravisCI
[ -f "$HOME/.travis/travis.sh" ] && source $HOME/.travis/travis.sh

# php-version
# See https://github.com/wilmoore/php-version
[ -f "$HOME/.php-version/php-version.sh" ] && source "$HOME/.php-version/php-version.sh"

# Add composer executables to path
[ -d "$HOME/.composer/vendor/bin" ] && export PATH="$HOME/.composer/vendor/bin:$PATH"

# direnv https://direnv.net/
if hash direnv 2>/dev/null; then eval "$(direnv hook zsh)"; fi

# base16
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# fzf
[ -f "/usr/share/fzf/key-bindings.zsh" ] && . /usr/share/fzf/key-bindings.zsh
[ -f "/usr/share/fzf/completion.zsh" ] && . /usr/share/fzf/completion.zsh

# todo.txt
alias todo=todo.sh
