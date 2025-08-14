#!/bin/bash

WALLPAPER_DIR="/mnt/F/Wallpapers/rwall"
INDEX_FILE="$HOME/.feh_wallpaper_index"
SLEEP_TIME=3600  # 60 minutes

# Read all wallpapers sorted alphabetically
mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) | sort)
TOTAL=${#WALLPAPERS[@]}

# Read last index or start from 0
if [[ -f "$INDEX_FILE" ]]; then
    INDEX=$(<"$INDEX_FILE")
else
    INDEX=0
fi

# Loop forever through wallpapers
while true; do
    feh --bg-scale "${WALLPAPERS[$INDEX]}"

    # Save current index for next session
    echo "$INDEX" > "$INDEX_FILE"

    # Increment and wrap around
    INDEX=$(( (INDEX + 1) % TOTAL ))

    sleep "$SLEEP_TIME"
done
