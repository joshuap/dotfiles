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
alias got='go test'

bvim() { vim `bundle show $1`; }

c() { cd ~/code/$1;  }

_c() { _files -W ~/code -/; }
compdef _c c
