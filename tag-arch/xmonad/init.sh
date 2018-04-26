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
# Commented out to let taffybar handle notifications.
# dunst -config $HOME/.dunstrc &

# Dropbox
dropbox &

# Network Manager Applet
nm-applet &

# Keyboard
XKBDIR=$HOME/.config/xkb
xkbcomp -synch -w3 -I$XKBDIR $XKBDIR/keymap/my-keymap $DISPLAY

# Signal systemctl that the window manager is ready to go.
systemctl --user start wm.target

# Restart xcape because... ?
systemctl --user restart xcape.service
