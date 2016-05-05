if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh"
  git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
else
  echo "Oh My Zsh is already installed; skipping."
fi
