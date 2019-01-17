#!/bin/sh
#
# Initializes the window manager.
# This should be called after starting i3/xmonad.

# Gnome Keyring is used by Chrome to store saved passwords.
if [ -f /usr/bin/gnome-keyring-daemon ]; then
  eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs12,secrets,ssh)
  export SSH_AUTH_SOCK
fi

# Notification daemon
dunst -config $HOME/.dunstrc &

# Window compositor
# See https://github.com/chjj/compton/issues/477
env allow_rgb10_configs=false compton &

# Set the wallpaper
$HOME/.lib/bin/wallpaper.sh

# Restart xcape because... ?
systemctl --user restart xcape.service
