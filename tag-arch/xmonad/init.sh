#!/bin/sh

DISPLAY=":0"

# ----------------------------------------------------------------------
# Keyboard
# ----------------------------------------------------------------------

XKBDIR=$HOME/.config/xkb
notify-send -u low "Keyboard initialized"
xkbcomp -synch -w3 -I$XKBDIR $XKBDIR/keymap/my-keymap $DISPLAY
(exec killall -q xcape) & # gets restarted by the xcape systemd user service
