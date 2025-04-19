#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Edited to gray out when playerctl is paused.

bar="▁▂▃▄▅▆▇█"
dict="s/;//g"

bar_length=${#bar}

for ((i = 0; i < bar_length; i++)); do
    dict+=";s/$i/${bar:$i:1}/g"
done

config_file="/tmp/bar_cava_config"
cat >"$config_file" <<EOF
[general]
framerate = 30
bars = 12

[input]
source = spotify

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
EOF

pkill -f "cava -p $config_file"

if ! command -v playerctl >/dev/null 2>&1; then
    echo "ERROR: playerctl not installed" >&2
    exit 1
fi

check_spotify_status() {
    if playerctl -p spotify status 2>/dev/null | grep -q "Playing"; then
        echo "playing"
    else
        echo "paused"
    fi
}

cava -p "$config_file" 2>/dev/null | while read -r line; do
    cava_output=$(echo "$line" | sed -u "$dict")
    
    status=$(check_spotify_status)
    
    if [ "$status" = "playing" ]; then
        echo "$cava_output"
    else
        echo "<span color='#4c566a'>$cava_output</span>"
    fi
done
