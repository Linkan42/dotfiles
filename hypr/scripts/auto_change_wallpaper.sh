#!/usr/bin/bash

if (( $# != 4 )); then
  echo "Usage: $0 <folder> <monitor> <min_seconds> <max_seconds>"
  exit 1
fi

FOLDER="$1"
MONITOR="$2"
MIN="$3"
MAX="$4"

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

while true; do
  waypaper --folder "$FOLDER" --monitor "$MONITOR" --random

  RAND=$(( RANDOM % (MAX - MIN + 1) + MIN ))
  sleep "$RAND"
done
