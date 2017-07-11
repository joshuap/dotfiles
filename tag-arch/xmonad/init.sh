#!/bin/sh

# ----------------------------------------------------------------------
# Autostart
# ----------------------------------------------------------------------

# Gnome Keyring is used by Chrome to store saved passwords.
if [ -f /usr/bin/gnome-keyring-daemon ]; then
  eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs12,secrets,ssh)
  export SSH_AUTH_SOCK
fi

# Menubar
taffybar &

# Wallpaper
feh --bg-fill ~/Pictures/wallpaper.jpg &

# Notification daemon
dunst -config $HOME/.dunstrc &

# Window compositor
compton &

# Screensaver/window locker
xscreensaver -no-splash &

# Dropbox
dropbox &

# Network Manager Applet
nm-applet &

# ----------------------------------------------------------------------
# Keyboard
# ----------------------------------------------------------------------

XKBDIR=$HOME/.config/xkb
xkbcomp -synch -w3 -I$XKBDIR $XKBDIR/keymap/my-keymap $DISPLAY
xcape -e "Hyper_L=Tab;Hyper_R=backslash"
notify-send -u low "Keyboard initialized"
