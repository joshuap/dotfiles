# Bundler aliases
alias be="bundle exec"
alias bi="bundle install"
alias bl="bundle list"
alias bp="bundle package"
alias bu="bundle update"
alias ber='bundle exec rake'
alias gap='git add -p'
alias got="go test"

alias cl="clear"

bvim() { vim `bundle show $1`; }

c() { cd ~/code/$1;  }

_c() { _files -W ~/code -/; }
compdef _c c
