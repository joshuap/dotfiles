#!/bin/sh

# Sets a random wallpaper.

WALLPAPER_DIR="$HOME/Pictures/Wallpaper/"

random_wallpaper() {
	find "$WALLPAPER_DIR" -type f -or -type l | shuf -n1
}

feh --bg-fill $(random_wallpaper)
