#!/usr/bin/env bash

# linux.sh

# The path to this repo.
ROOT=$PWD

# Temporary directory.
TMP=$ROOT/tmp

# The global ruby version to install via rbenv.
RUBY_VERSION=2.2.2

# The go version to install.
GO_VERSION=1.4.2

# Ask for the administrator password upfront.
sudo -v

# Create tmp directory if missing.
if [ ! -d "$TMP" ]; then
  mkdir $TMP
fi

# Create required directories.
mkdir -p ~/code/go ~/bin

# Add PPA sources.
sudo add-apt-repository -y ppa:webupd8team/java
sudo add-apt-repository -y ppa:xorg-edgers/ppa
if [ ! -e "/etc/apt/trusted.gpg.d/apt.postgresql.org.gpg" ]; then sudo sh $ROOT/linux/apt.postgresql.org.sh; fi
sudo apt-get update

# Configure gfx card drivers.
sudo apt-get -y install nvidia-346

# Set a fast key repeat rate.
gsettings set org.gnome.settings-daemon.peripherals.keyboard repeat-interval 15
gsettings set org.gnome.settings-daemon.peripherals.keyboard delay 250

# Set the desktop background.
gsettings set org.gnome.desktop.background picture-uri "file://$ROOT/images/wallpaper-gray-planks.jpg"

# Disable blinking cursor in text fields.
gsettings set org.gnome.desktop.interface cursor-blink false

# Install Steam.
sudo apt-get -y install steam

# Install developer stuff.
sudo apt-get -y install libreadline-dev git mercurial vim zsh ruby ruby-dev rbenv rake libssl-dev build-essential cmake python-dev libncurses5-dev oracle-java7-installer irssi tmux postgresql-9.4 postgresql-contrib-9.4 postgresql-server-dev-9.4 autotools-dev automake libtool redis-server

# Ensure rbenv is using system ruby (important for compiling vim plugins).
rbenv global system

# Install ruby-build plugin for rbenv.
mkdir -p ~/.rbenv/plugins
if [ ! -d "$HOME/.rbenv/plugins/ruby-build" ]; then
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

# Install Go
GO_ARCHIVE=go$GO_VERSION.linux-amd64.tar.gz
if [ ! -d "/usr/local/go" ]; then
  rm $TMP/$GO_ARCHIVE
  wget -O $TMP/$GO_ARCHIVE https://storage.googleapis.com/golang/$GO_ARCHIVE
  sudo tar -C /usr/local -xzf $TMP/$GO_ARCHIVE
  # Add the go bin to the path so we can use it now.
  export PATH=/usr/local/go/bin:$PATH
fi

# Install vim w/ Ruby support.
if ! hash vim 2>/dev/null; then
  rm -rf $TMP/vim/
  hg clone https://vim.googlecode.com/hg/ $TMP/vim
  cd $TMP/vim
  ./configure --with-features=huge --enable-rubyinterp --enable-pythoninterp --prefix=$HOME
  make
  sudo make install
  cd $ROOT
fi

# Install oh-my-zsh.
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

  rm -rf ~/.oh-my-zsh/custom
  ln -s $ROOT/oh-my-zsh/custom ~/.oh-my-zsh

  if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc.orig;
  fi
  ln -s $ROOT/.zshrc ~/.zshrc
fi

sudo chsh -s /bin/zsh

# Install hub.
if ! hash hub 2>/dev/null; then
  rm -rf $TMP/hub
  git clone https://github.com/github/hub.git $TMP/hub
  cd $TMP/hub
  script/build && sudo mv ./hub ~/bin/hub
  cd $ROOT
fi

# Set up vim-pathogen.
if [ ! -f "$HOME/.vim/autoload/pathogen.vim" ]; then
  mkdir -p ~/.vim/autoload && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

if [ ! -d "$HOME/.vim/bundle" ]; then
  git submodule update --init --recursive
  ln -s $ROOT/vim/bundle ~/.vim

  # Compile YouCompleteMe plugin.
  cd ./vim/bundle/YouCompleteMe/ && sh install.sh --clang-completer
  cd $ROOT

  # Compile Command-T.
  cd ./vim/bundle/Command-T && rake make
  cd $ROOT

  # Reset changes introduced by compilation.
  git submodule foreach --recursive git checkout .
fi

# Link vim color file.
mkdir -p ~/.vim/colors
ln -sf $ROOT/vim/colors/desertEx.vim ~/.vim/colors

# Link up other dotfiles.
ln -sf $ROOT/.gitignore ~/.gitignore
ln -sf $ROOT/.irbrc ~/.irbrc
ln -sf $ROOT/.powconfig ~/.powconfig
ln -sf $ROOT/.psqlrc ~/.psqlrc
ln -sf $ROOT/.railsrc ~/.railsrc
ln -sf $ROOT/.vimrc ~/.vimrc
ln -sf $ROOT/.tmux.conf ~/.tmux.conf

# Install Ruby.
rbenv install -s $RUBY_VERSION
rbenv global $RUBY_VERSION
eval "$(rbenv init -)"
if ! hash bundle 2>/dev/null; then gem install bundler && rbenv rehash; fi

echo "Installation complete!"
