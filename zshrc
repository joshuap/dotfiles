# Load homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Load Antigen from submodule
DOTFILES=$HOME/.dotfiles
source $DOTFILES/antigen/antigen.zsh

# Load oh-my-zsh
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh)
antigen bundle git
antigen bundle git-extras
antigen bundle gem
antigen bundle macos
antigen bundle bundler
antigen bundle brew
antigen bundle asdf
antigen bundle gpg-agent
antigen bundle blimmer/zsh-aws-vault@main
antigen bundle zsh-users/zsh-autosuggestions

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

# Check for Homebrew updates once per hour.
export HOMEBREW_AUTO_UPDATE_SECS=3600

alias vim=nvim

export EDITOR='nvim'
# export EDITOR='code'

alias http="python3 -m http.server"

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

# asdf
[ -f ~/.asdf/asdf.sh ] && source ~/.asdf/asdf.sh

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

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

# iTerm2
# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# https://alexmanrique.com/blog/development/2021/01/05/first-steps-using-java-in-macbook-air-m1.html
# https://docs.azul.com/core/zulu-openjdk/install/macos
# https://www.azul.com/downloads/?version=java-8-lts&os=macos&architecture=arm-64-bit&package=jdk
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/home

# Need this to solve cmake issues (i.e. w/ `gem install snappy`)
# https://apple.stackexchange.com/a/414625
export CPATH=/opt/homebrew/include
export LIBRARY_PATH=/opt/homebrew/lib

# https://gist.github.com/nazgob/1570678
alias ctags="`brew --prefix`/bin/ctags"

# From shalvah
# There was another npm supply chain attack last month. A patch version of a package was released that stole credentials from the user's computer.
# https://github.com/faisalman/ua-parser-js/issues/536
# Recommend committing package-lock.json and using npm ci --production=false rather than npm install to mitigate this on your projects, since npm install silently auto-updates your dependencies.
alias 'npm install'='npm ci --production=false'

# Required for `ssh-add -l` to work
# https://developer.1password.com/docs/ssh/get-started#step-4-configure-your-ssh-or-git-client
export SSH_AUTH_SOCK=`pwd`/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

# For Dart
# (`brew install dart-sdk`)
export PATH="$PATH":"$HOME/.pub-cache/bin"
