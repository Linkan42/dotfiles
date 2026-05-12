#!/usr/bin/env bash
# auto_change_wallpaper.sh
# Usage: auto_change_wallpaper.sh <folder> <monitor> <min_seconds> <max_seconds>
# If <monitor> is empty or "-" the image will be shown on all outputs.

set -euo pipefail

if (( $# != 4 )); then
  echo "Usage: $0 <folder> <monitor|' - ' for all> <min_seconds> <max_seconds>"
  exit 1
fi

FOLDER="$1"
MONITOR="$2"
MIN="$3"
MAX="$4"

# sanity checks
if ! command -v awww >/dev/null 2>&1; then
  echo "Error: awww is not installed or not on PATH."
  exit 1
fi

if ! [[ "$MIN" =~ ^[0-9]+$ ]] || ! [[ "$MAX" =~ ^[0-9]+$ ]]; then
  echo "Error: min_seconds and max_seconds must be integers."
  exit 1
fi

if (( MIN >= MAX )); then
  echo "Error: min_seconds must be less than max_seconds."
  exit 1
fi

if [[ ! -d "$FOLDER" ]]; then
  echo "Error: '$FOLDER' is not a directory."
  exit 1
fi

# lockfile per monitor so multiple monitor scripts can run simultaneously
LOCKDIR="${XDG_CACHE_HOME:-$HOME/.cache}"
# sanitize monitor name for filenames: replace commas/spaces with underscores
LOCK_MONITOR="$(echo "$MONITOR" | tr ' ,/' '__' )"
lockfile="$LOCKDIR/auto_wallpaper_change.${LOCK_MONITOR}.lock"

# file extensions to consider (case-insensitive)
extensions=(jpg jpeg png gif webp bmp)

# pick random file from folder (recursively)
pick_random_image() {
  # build find predicate
  local -a preds
  for ext in "${extensions[@]}"; do
    preds+=( -iname "*.${ext}" -o )
  done
  # remove trailing -o
  unset 'preds[${#preds[@]}-1]'

  # Use find to build list, then read into array
  mapfile -t files < <(find "$FOLDER" -type f \( "${preds[@]}" \) 2>/dev/null || true)

  if (( ${#files[@]} == 0 )); then
    return 1
  fi

  # RANDOM is 0..32767. Use it to index the array (good enough here).
  echo "${files[RANDOM % ${#files[@]}]}"
  return 0
}

# main loop
while true; do
  (
    # open lock fd 200 and lock it
    exec 200>"$lockfile"
    flock -x 200

    img="$(pick_random_image)" || {
      echo "No images found in: $FOLDER" >&2
      exit 1
    }

    # If monitor is "-" or empty, don't pass --outputs (awww will display on all outputs)
    if [[ -z "$MONITOR" || "$MONITOR" == "-" ]]; then
      awww img --resize stretch --transition-type any --transition-fps 144 "$img"
    else
      awww img --outputs "$MONITOR" --resize stretch --transition-type any --transition-fps 144 "$img"
    fi
  ) 200>"$lockfile"

  # sleep random interval between MIN and MAX seconds (inclusive)
  # Use shuf for wider range randomness if available, fallback to $RANDOM
  if command -v shuf >/dev/null 2>&1; then
    RAND="$(shuf -i "$MIN"-"$MAX" -n 1)"
  else
    RANGE=$(( MAX - MIN + 1 ))
    RAND=$(( RANDOM % RANGE + MIN ))
  fi

  sleep "$RAND"
done
