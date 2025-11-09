#!/usr/bin/env bash

shopt -s nullglob globstar

SOURCE_CONFIG_HOME=$(realpath "$(dirname "$0")/../config")
TARGET_CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME/.config"}

for source_path in "$SOURCE_CONFIG_HOME"/**/*; do
    rel_path=${source_path#"$SOURCE_CONFIG_HOME/"}
    target_path="$TARGET_CONFIG_HOME/$rel_path"
    if [[ -d "$source_path" ]]; then
        if [[ -d "$target_path" ]]; then

            for subfile in "$target_path"/*; do
                if [[ ! -d "$subfile" ]]; then
                    if [[ ! -L "$subfile" ]]; then
                        echo "Adopging $subfile"
                        echo mv "$subfile" "$source_path"
                        echo "Linking $source_path/$(basename "$subfile")  ->  $subfile"
                    fi
                fi
            done

        else
            echo mkdir -p "$target_path"
        fi

    elif [[ -f "$source_path" ]]; then
        if [[ ! -e "$target_path" ]]; then
            echo "Linking $source_path  ->  $target_path"
            echo ln -s "$source_path" "$target_path"
        fi
    fi
done

exit 0
