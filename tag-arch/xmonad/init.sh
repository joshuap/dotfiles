#!/bin/sh

# ----------------------------------------------------------------------
# Autostart
# ----------------------------------------------------------------------

# Gnome Keyring is used by Chrome to store saved passwords.
if [ -f /usr/bin/gnome-keyring-daemon ]; then
  eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs12,secrets,ssh)
  export SSH_AUTH_SOCK
fi

# Wallpaper
feh --bg-fill ~/Pictures/wallpaper.jpg &

# Notification daemon
dunst -config $HOME/.dunstrc &

# Window compositor
compton &

# Screensaver/window locker
xscreensaver -no-splash &

# System tray; must be active while launching Dropbox, for some reason,
# otherwise the icon doesn't appear in the tray. nm-applet seems fine without
# this. See the `killall -q stalonetray` later in the script.
stalonetray &

# Dropbox
dropbox &

# Network Manager Applet
nm-applet &

# Kill the tray after starting applications, since I have a keyboard shortcut
# to activate it. The sleep is to give Dropbox time to initialize.
sleep 2
killall -q stalonetray

# ----------------------------------------------------------------------
# Keyboard
# ----------------------------------------------------------------------

XKBDIR=$HOME/.config/xkb
xkbcomp -synch -w3 -I$XKBDIR $XKBDIR/keymap/my-keymap $DISPLAY
xcape -e "Hyper_L=Tab;Hyper_R=backslash"
notify-send -u low "Keyboard initialized"
