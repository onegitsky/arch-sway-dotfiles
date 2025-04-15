#!/usr/bin/env python3

import os
import subprocess
import random
import glob
import sys

# Directory containing your wallpapers
WALLPAPER_DIR = os.path.expanduser("~/Pictures/Wallpapers/swww")

# Ensure the directory exists
if not os.path.isdir(WALLPAPER_DIR):
    print(f"Wallpaper directory not found: {WALLPAPER_DIR}")
    sys.exit(1)

# Get list of wallpapers (jpg, png, gif)
wallpapers = glob.glob(f"{WALLPAPER_DIR}/*.[jJ][pP][gG]") + \
             glob.glob(f"{WALLPAPER_DIR}/*.[pP][nN][gG]") + \
             glob.glob(f"{WALLPAPER_DIR}/*.[gG][iI][fF]")

# Check if any wallpapers were found
if not wallpapers:
    print(f"No wallpapers found in {WALLPAPER_DIR}")
    sys.exit(1)

# Select random wallpaper
wallpaper = random.choice(wallpapers)

# Check if swww-daemon is running, start it if not
try:
    subprocess.run(["pgrep", "-f", "swww-daemon"], check=True, capture_output=True)
except subprocess.CalledProcessError:
    subprocess.Popen(["swww-daemon", "--format", "xrgb"])
    import time
    time.sleep(1)

# Apply the wallpaper with swww
subprocess.run([
    "swww", "img", wallpaper,
    "--transition-type", "any",
    "--transition-step", "60",
    "--transition-fps", "60",
    "--transition-duration", "1"
])

# Output the current wallpaper
print(f"Set wallpaper to: {wallpaper}")
