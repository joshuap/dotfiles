#!/bin/sh

# arch.sh

# Ask for the administrator password upfront.
sudo -v

# Create required directories.
mkdir -p $HOME/code/go $HOME/bin

# These should be included when running `pacstrap`.
sudo pacman -S --needed git vim

# Dotfiles dependencies.
sudo pacman -S --needed imagemagick hub

# Keyboard.
sudo pacman -S --needed xbindkeys alsa-utils alsa-firmware

# Display
sudo pacman -S --needed xf86-video-intel

# Set a fast keyboard repeat rate.
kbdrate -d10 -r30.0

# Enable sound.
# amixer sset Master unmute
# Perform this manually if necessary:
# alsamixer
# Turn up the master volume, then hit f4 and enable Mic, then:
# speaker-test -c 2

# Better trackpad support.
# See https://wiki.archlinux.org/index.php/Touchpad_Synaptics#Configuration
sudo pacman -S --needed xf86-input-synaptics
if [ ! -f "/etc/X11/xorg.conf.d/50-synaptics.conf" ]; then
  cp /usr/share/X11/xorg.conf.d/50-synaptics.conf /etc/X11/xorg.conf.d
fi

# xmonad packages.
sudo pacman -S --needed xmonad xmobar dmenu gmrun xorg-xmessage xcompmgr transset-df xorg-xdpyinfo feh

# IRC chat.
sudo pacman -S --needed irssi

# Audio player.
sudo pacman -S --needed gogglesmm

# Misc. stuff I use.
sudo pacman -S --needed trash-can openvpn openresolv go elixir

sh ./bootstrap/shared/oh-my-zsh.sh
sh ./bootstrap/shared/vim-plug.sh

# TODO: Copy ~/.gitconfig and ~/.irssi/config (I currently do this manually
# because they contain secrets).

rcup -v -t arch

echo "Installation complete!"
