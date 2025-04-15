#!/bin/bash

# Path to custom icons
ICON_PATH="$HOME/.local/share/icons/dunst/"

# Get volume from playerctl (Spotify)
VOLUME=$(playerctl -p spotify metadata --format '{{volume * 100}}' | cut -d '.' -f 1)

# Check if player is muted or volume is 0
if [ -z "$VOLUME" ] || [ "$VOLUME" -eq 0 ]; then
    IS_MUTED="true"
else
    IS_MUTED="false"
fi

# Get track position and duration
POSITION=$(playerctl -p spotify metadata --format '{{duration(position)}}')
DURATION=$(playerctl -p spotify metadata --format '{{duration(mpris:length)}}')

# Select icon based on volume level or mute state
if [ "$IS_MUTED" = "true" ]; then
    ICON="$ICON_PATH/volume-mute.svg"
elif [ "$VOLUME" -lt 33 ]; then
    ICON="$ICON_PATH/volume-low.svg"
elif [ "$VOLUME" -lt 66 ]; then
    ICON="$ICON_PATH/volume-medium.svg"
else
    ICON="$ICON_PATH/volume-high.svg"
fi

# Set volume display for notification (show 0% if muted)
DISPLAY_VOLUME=${VOLUME:-0}

# Send notification using dunstify with built-in progress bar
dunstify -t 2000 -i "$ICON" -a "Spotify" -u low -h string:x-dunst-stack-tag:volume \
    -h int:value:"$DISPLAY_VOLUME" \
    "Spotify Volume: ${DISPLAY_VOLUME}%" \
    "${POSITION}/${DURATION}"
