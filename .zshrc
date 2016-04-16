# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="joshuap"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git gem osx joshuap)

source $ZSH/oh-my-zsh.sh

export EDITOR='vim'

if [ $(uname -s) = 'Darwin' ]; then
  plugins+=(brew)

  export LANG="en_AU.UTF-8"
  export PATH="$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/X11/bin"
  export MANPATH="/usr/local/share/man:/usr/X11/man:/usr/share/man"
  export SSL_CERT_FILE=/usr/local/share/ca-bundle.crt

  # To use Homebrew's directories rather than ~/.rbenv add to your profile:
  export RBENV_ROOT=/usr/local/var/rbenv

  # Enable mactex
  export PATH="/usr/texbin:$PATH"

  # Use Java 1.7
  export JAVA_HOME=`/usr/libexec/java_home -v '1.7*'`

  # Golang
  export PATH=/usr/local/go/bin:$PATH

  # Node
  export NVM_DIR=~/.nvm
  . $(brew --prefix nvm)/nvm.sh

  # PHP
  export PATH="/usr/local/sbin:$PATH"
  export PATH="$(brew --prefix homebrew/php/php56)/bin:$PATH"
else
  export PATH=$HOME/bin:/usr/local/go/bin:$PATH

  # Use Java 1.8
  export JAVA_HOME=/usr/lib/jvm/java-8-oracle
fi

# Add Java bin to path.
export PATH=$JAVA_HOME/bin:$PATH

# To enable shims and autocompletion add to your profile:
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

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

# Go setup
export GOPATH=$HOME/code/go
export PATH=$PATH:$GOPATH/bin

# Global binstubs
export PATH="./bin:$PATH"

# https://hub.github.com/
if hash hub 2>/dev/null; then alias git=hub; fi

# added by travis gem
[ -f "$HOME/.travis/travis.sh" ] && source $HOME/.travis/travis.sh

# Add composer executables to path
[ -d "$HOME/.composer/vendor/bin" ] && export PATH="$HOME/.composer/vendor/bin:$PATH"

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh
