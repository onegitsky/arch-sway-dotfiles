#!/usr/bin/env python3

import subprocess
import requests
from PIL import Image
import os
import io

# Get metadata
def get_metadata(key):
    try:
        return subprocess.check_output(
            ['playerctl', '--player=spotify', 'metadata', '--format', f'{{{{{key}}}}}'],
            text=True
        ).strip()
    except subprocess.CalledProcessError:
        return ""

artist = get_metadata("artist")
title = get_metadata("title")
art_url = get_metadata("mpris:artUrl")

# Combine artist and title into a single line
track_info = f"{artist} - {title}" if artist and title else title or artist or "Unknown Track"

# Temporary icon path
temp_icon = "/tmp/spotify_album_art.png"

# Download and convert album art
if art_url:
    try:
        response = requests.get(art_url, timeout=5)
        if response.ok:
            image = Image.open(io.BytesIO(response.content))
            image.save(temp_icon)
    except Exception as e:
        print(f"Failed to download or process album art: {e}")

# Send notification with clear title
def send_notification(icon_path=None):
    notif_title = "Track Skipped:"
    timeout = "2500"
    if icon_path and os.path.exists(icon_path):
        subprocess.run(['notify-send', '-t', timeout, '-i', icon_path, notif_title, track_info])
    else:
        subprocess.run(['notify-send', '-t', timeout, notif_title, track_info])

send_notification(temp_icon if os.path.exists(temp_icon) else None)

# Clean up
if os.path.exists(temp_icon):
    os.remove(temp_icon)

