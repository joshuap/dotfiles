autoload compinit && compinit

alias b='bundler'
alias be='bundle exec'
alias bi='bundle install'
alias bl='bundle list'
alias bp='bundle package'
alias bu='bundle update'
alias ber='bundle exec rake'

alias cl='clear'

# This replaces the ghostscript `gs` command on some systems, which is still
# available via `ghostscript`.
alias gs='git status'

alias gap='git add -p'
alias gpr='git pull-request'
alias grm='git rebase -i master'

alias got='go test'

alias n='npm'
alias ni='npm install'

alias y='yarn'
alias yi='yarn install'

alias v=nvim

bvim() { vim `bundle show $1`; }

c() { cd ~/code/$1;  }

_c() { _files -W ~/code -/; }
compdef _c c

# Inspired by https://stackoverflow.com/a/1885534
function confirm {
  echo -n "${@} (y/n): " && read -r -k1
  echo # move to a new line
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    [[ ! -o interactive ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
  fi
}
