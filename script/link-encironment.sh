#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

target_path=${XDG_CONFIG_HOME:-$HOME/.config}/environment.d
source_path=$(realpath "$SCRIPT_DIR/../environment.d")

if [ -d $target_path ]; then
    echo "$target_path already exists, skipping"
elif [ ! -e $source_path ]; then
    echo "$source_path doesn't exist, skipping"
else
    ln -s "$source_path" "$target_path"
fi
