#!/bin/sh

# ----------------------------------------------------------------------
# Keyboard
# ----------------------------------------------------------------------

XKBDIR=$HOME/.config/xkb
xkbcomp -synch -w3 -I$XKBDIR $XKBDIR/keymap/my-keymap $DISPLAY
xcape -e "Hyper_L=Tab;Hyper_R=backslash"
notify-send -u low "Keyboard initialized"
