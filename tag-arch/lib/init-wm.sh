#!/bin/sh
#
# Initializes the window manager.
# This should be called after starting xmonad.

# Gnome Keyring is used by Chrome to store saved passwords.
if [ -f /usr/bin/gnome-keyring-daemon ]; then
  eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs12,secrets,ssh)
  export SSH_AUTH_SOCK
fi

# Notification daemon
# Commented out to let taffybar handle notifications.
# NOTE: This will move to a service if reenabled.
# dunst -config $HOME/.dunstrc &

# Keyboard
XKBDIR=$HOME/.config/xkb
xkbcomp -synch -w3 -I$XKBDIR $XKBDIR/keymap/my-keymap $DISPLAY

# Signal systemctl that the window manager is ready to go.
systemctl --user start wm.target

# Signal systemctl to start systemd/Timers.
systemctl --user start timers.target

# Restart xcape because... ?
systemctl --user restart xcape.service
