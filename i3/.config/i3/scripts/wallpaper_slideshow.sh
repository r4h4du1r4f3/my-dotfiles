#!/bin/bash

WALLPAPER_DIR="/mnt/F/Wallpapers/Wallpapers/anime/"
INDEX_FILE="$HOME/.feh_wallpaper_index"
CONTROL_FILE="$HOME/.feh_wallpaper_control"
SLEEP_TIME=3600

mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) | sort)
TOTAL=${#WALLPAPERS[@]}

[[ $TOTAL -eq 0 ]] && echo "No wallpapers in $WALLPAPER_DIR" && exit 1

# Load last index
INDEX=0
[[ -f "$INDEX_FILE" ]] && INDEX=$(<"$INDEX_FILE")
[[ "$INDEX" -ge "$TOTAL" ]] && INDEX=0

PAUSED=true

set_wallpaper() {
  feh --no-fehbg --bg-fill "${WALLPAPERS[$INDEX]}"
  echo "$INDEX" >"$INDEX_FILE"
}

set_wallpaper

while true; do
  if [[ "$PAUSED" == true ]]; then
    # Only wait for control file changes
    inotifywait -q -e modify "$CONTROL_FILE" >/dev/null 2>&1 || sleep 1
  else
    # Wait either for control file or timeout
    inotifywait -q -t "$SLEEP_TIME" -e modify "$CONTROL_FILE" >/dev/null 2>&1
    if [[ $? -ne 0 ]]; then
      # Timeout expired → next wallpaper
      INDEX=$(((INDEX + 1) % TOTAL))
      set_wallpaper
      continue
    fi
  fi

  # Read and clear control command
  if [[ -s "$CONTROL_FILE" ]]; then
    CMD=$(<"$CONTROL_FILE")
    >"$CONTROL_FILE"
    case "$CMD" in
    next)
      INDEX=$(((INDEX + 1) % TOTAL))
      set_wallpaper
      ;;
    prev)
      INDEX=$(((INDEX - 1 + TOTAL) % TOTAL))
      set_wallpaper
      ;;
    pause) PAUSED=true ;;
    resume) PAUSED=false ;;
    esac
  fi
done
