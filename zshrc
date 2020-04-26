# Load Antigen from submodule
DOTFILES=$HOME/.dotfiles
source $DOTFILES/antigen/antigen.zsh

# Load oh-my-zsh
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh)
antigen bundle git
antigen bundle git-extras
antigen bundle gem
antigen bundle osx
antigen bundle bundler
antigen bundle brew
antigen bundle asdf

# Other bundles
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle chriskempson/base16-shell

# Local bundles (including theme)
antigen bundle $DOTFILES/oh-my-zsh/custom themes/lambda.zsh-theme --no-local-clone
antigen bundle $DOTFILES/oh-my-zsh/custom plugins/joshuap --no-local-clone

# Tell Antigen that you're done
antigen apply


##
# User Configuration

# ~/.bin is for my scripts and executables.
export PATH=$HOME/.bin:$PATH

# Global binstubs (i.e. for Bundler)
export PATH="./bin:$PATH"

# Homebrew requires this path.
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"

# Install applications to ~/Applications using homebrew cask.
export HOMEBREW_CASK_OPTS="--appdir=~/Applications"

alias vim=nvim

export EDITOR='vim'

alias http="python -m http.server"

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

# hub
# https://hub.github.com/
# Wrapping the function makes tab completion work for git+hub+git-extras.
# See https://github.com/robbyrussell/oh-my-zsh/issues/766
if hash hub 2>/dev/null; then function git(){hub $@}; fi

# TravisCI
[ -f "$HOME/.travis/travis.sh" ] && source $HOME/.travis/travis.sh

# php-version
# See https://github.com/wilmoore/php-version
[ -f "$HOME/.php-version/php-version.sh" ] && source "$HOME/.php-version/php-version.sh"

# Add composer executables to path
[ -d "$HOME/.composer/vendor/bin" ] && export PATH="$HOME/.composer/vendor/bin:$PATH"

# direnv https://direnv.net/
if hash direnv 2>/dev/null; then eval "$(direnv hook zsh)"; fi

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# todo.txt
alias todo=todo.sh
alias td=todo.sh

# Docker development setup (Honeybadger repos)
export DOCKER_DEVELOPER_UID=1000
export DOCKER_DEVELOPER_GID=985

# https://github.com/drduh/YubiKey-Guide#replace-agents
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
