# Set a fast keyboard repeat rate.
xset r rate 200 50

# Configure xkb.
XKBDIR=$HOME/.config/xkb
xkbcomp -synch -w3 -I$XKBDIR $XKBDIR/keymap/my-keymap $DISPLAY
