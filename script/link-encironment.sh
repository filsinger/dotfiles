#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

target_path=${XDG_CONFIG_HOME:-$HOME/.config}/environment.d
source_path=$(realpath "$SCRIPT_DIR/../environment.d")
ln -s "$source_path" "$target_path"

