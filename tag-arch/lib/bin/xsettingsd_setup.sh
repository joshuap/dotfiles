#!/bin/sh

dpi="$1"

if [ -z $dpi ]; then
    # Don't try to guess DPI. For a laptop, we don't want the same DPI as
    # for an external screen. Just hardcode stuff...
    case $(hostname),$(xrandr --current | \
                           sed -n 's/\([^ ]*\) connected .*[0-9][0-9]*x[0-9][0-9]*+[0-9][0-9]*+[0-9][0-9]* .*/\1/p' | \
                           sort | tr '\n' ':') in
        zoltan,DP-1:) dpi=100 ;;
        lenny,*:) dpi=128 ;;
        *) dpi=100 ;;
    esac
fi

echo "Setting dpi to $dpi"

# Build xsettingsd.local
cp  ~/.xsettingsd ~/.xsettingsd.local
echo Xft/DPI $(( $dpi * 1024 )) >> ~/.xsettingsd.local

# Also use xrdb for very old stuff (you know, LibreOffice)
echo Xft.dpi: "$dpi" | xrdb -merge

# Signal xsettingsd
pid=$(xprop -name xsettingsd _NET_WM_PID 2> /dev/null | awk '{print $NF}')
if [ x"$pid" = x ]; then
    xsettingsd -c ~/.xsettingsd.local
else
    kill -HUP $pid
fi
