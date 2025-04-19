#!/usr/bin/env python3

import os
import subprocess
import random
import glob
import sys

WALLPAPER_DIR = os.path.expanduser("~/Pictures/Wallpapers/swww")

if not os.path.isdir(WALLPAPER_DIR):
    print(f"Wallpaper directory not found: {WALLPAPER_DIR}")
    sys.exit(1)

wallpapers = glob.glob(f"{WALLPAPER_DIR}/*.[jJ][pP][gG]") + \
             glob.glob(f"{WALLPAPER_DIR}/*.[pP][nN][gG]") + \
             glob.glob(f"{WALLPAPER_DIR}/*.[gG][iI][fF]")

if not wallpapers:
    print(f"No wallpapers found in {WALLPAPER_DIR}")
    sys.exit(1)

wallpaper = random.choice(wallpapers)

try:
    subprocess.run(["pgrep", "-f", "swww-daemon"], check=True, capture_output=True)
except subprocess.CalledProcessError:
    subprocess.Popen(["swww-daemon", "--format", "xrgb"])
    import time
    time.sleep(1)

subprocess.run([
    "swww", "img", wallpaper,
    "--transition-type", "any",
    "--transition-step", "60",
    "--transition-fps", "60",
    "--transition-duration", "1"
])

print(f"Set wallpaper to: {wallpaper}")
