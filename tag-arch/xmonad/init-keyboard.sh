# Load custom keys.
XKBDIR=$HOME/.config/xkb
xkbcomp -synch -w3 -I$XKBDIR $XKBDIR/keymap/my-keymap $DISPLAY

# Set a fast keyboard repeat rate.
xset r rate 150 100

# Load xcape for tab/backslash to double as modifier on long-press. Kill
# existing processes since this script may be called more than once.
pkill xcape
xcape -e "Hyper_L=Tab;Hyper_R=backslash"

notify-send -u low "Keyboard initialized"
