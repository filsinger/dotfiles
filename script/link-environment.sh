#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

TARGET_DIRECTORY="${XDG_CONFIG_HOME:-$HOME/.config}/environment.d"
SOURCE_DIRECTORY=$(realpath "$SCRIPT_DIR/../config/environment.d")

[[ ! -d "$TARGET_DIRECTORY" ]] && mkdir -p "$TARGET_DIRECTORY"

for f in "$SOURCE_DIRECTORY"/*.conf; do
    TARGET_PATH="$TARGET_DIRECTORY/$(basename "$f")"
    if [[ -e $TARGET_PATH ]]; then
        echo "$TARGET_PATH already exists, skipping"
    else
        ln -s "$f" "$TARGET_PATH"
    fi
done
