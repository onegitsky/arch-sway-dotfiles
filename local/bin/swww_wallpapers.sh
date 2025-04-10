#!/bin/bash

# Directory containing your wallpapers (change this to your wallpaper folder)
WALLPAPER_DIR="$HOME/Pictures/Wallpapers/swww"

if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Wallpaper directory not found: $WALLPAPER_DIR"
    exit 1
fi

WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.gif" \) | shuf -n 1)

if [ -z "$WALLPAPER" ]; then
    echo "No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

if ! pgrep -f "swww-daemon" > /dev/null; then
    swww-daemon --format xrgb &
    sleep 1
fi

swww img "$WALLPAPER" --transition-type any --transition-step 60 --transition-fps 60 --transition-duration 1
echo "Set wallpaper to: $WALLPAPER"
