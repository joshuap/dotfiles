# Bundler aliases
alias be="bundle exec"
alias bi="bundle install"
alias bl="bundle list"
alias bp="bundle package"
alias bu="bundle update"

# Git aliases
alias gap="git add -p"

if [ $(uname -s) = 'Darwin' ]; then
  export LANG="en_AU.UTF-8"
  export EDITOR='mvim'
  export PATH="$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/X11/bin"
  export MANPATH="/usr/local/share/man:/usr/X11/man:/usr/share/man"
  export SSL_CERT_FILE=/usr/local/share/ca-bundle.crt
else
  export PATH="$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"
fi

# Global binstubs
export PATH="./bin:$PATH"

# https://hub.github.com/
alias git=hub
