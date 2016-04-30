#!/usr/bin/env bash

# arch.sh

# The path to this repo.
ROOT=$PWD

# Temporary directory.
TMP=$ROOT/tmp

# Create tmp directory if missing.
if [ ! -d "$TMP" ]; then
  mkdir $TMP
fi

# Create required directories.
mkdir -p $HOME/code/go $HOME/bin

# TODO: Copy ~/.gitconfig (I currently do this manually because it contains
# secrets).

# Install oh-my-zsh.
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh

  if [ -f $HOME/.zshrc ] || [ -h $HOME/.zshrc ]; then
    mv $HOME/.zshrc $HOME/.zshrc.orig;
  fi
  ln -s $ROOT/.zshrc $HOME/.zshrc
fi

rm -rf $HOME/.oh-my-zsh/custom
ln -s $ROOT/oh-my-zsh/custom $HOME/.oh-my-zsh


# Install hub.
if ! hash hub 2>/dev/null; then
  rm -rf $TMP/hub
  git clone https://github.com/github/hub.git $TMP/hub
  cd $TMP/hub
  script/build && mv ./bin/hub $HOME/bin/hub
  cd $ROOT
fi

# Set up vim-pathogen.
if [ ! -f "$HOME/.vim/autoload/pathogen.vim" ]; then
  mkdir -p $HOME/.vim/autoload && \
  curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

if [ ! -d "$HOME/.vim/bundle" ]; then
  git submodule update --init --recursive
  ln -s $ROOT/vim/bundle $HOME/.vim

  # Compile Command-T.
  cd ./vim/bundle/Command-T && rake make
  cd $ROOT

  # Reset changes introduced by compilation.
  git submodule foreach --recursive git checkout .
fi

# Link vim color file.
mkdir -p $HOME/.vim/colors
ln -sf $ROOT/vim/colors/desertEx.vim $HOME/.vim/colors

# Link up other dotfiles.
ln -sf $ROOT/.gitignore $HOME/.gitignore
ln -sf $ROOT/.irbrc $HOME/.irbrc
ln -sf $ROOT/.powconfig $HOME/.powconfig
ln -sf $ROOT/.psqlrc $HOME/.psqlrc
ln -sf $ROOT/.railsrc $HOME/.railsrc
ln -sf $ROOT/.vimrc $HOME/.vimrc
ln -sf $ROOT/.tmux.conf $HOME/.tmux.conf

echo "Installation complete!"
