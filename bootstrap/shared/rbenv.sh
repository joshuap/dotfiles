#!/bin/sh

# Install rbenv
if [ ! -d "$HOME/.rbenv" ]; then
  git clone https://github.com/rbenv/rbenv.git $HOME/.rbenv
  git clone https://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build
  cd $HOME/.rbenv
  ./src/configure && make -C src
fi
