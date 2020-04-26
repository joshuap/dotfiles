#!/bin/sh
#
# Initializes the window manager.
# This should be called after starting i3/xmonad.

# Gnome Keyring is used by Chrome to store saved passwords.
# (now loaded by PAM & xdm)
# if [ -f /usr/bin/gnome-keyring-daemon ]; then
#   eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs12,secrets,ssh)
#   export SSH_AUTH_SOCK
# fi

# Notification daemon
dunst -config $HOME/.dunstrc &

# Window compositor
# See https://github.com/chjj/compton/issues/477
# TODO: might delete compton. Need to see if it really prevents screen tearing/slow chrome repaints.
env allow_rgb10_configs=false compton &

# Detect display layout
autorandr --change

# Set the wallpaper
$HOME/.lib/bin/wallpaper.sh

# Use tab and \ as modifier keys when held
xcape -e "Hyper_L=Tab;Hyper_R=backslash"
