#!/usr/bin/env bash

# Install .desktop files in the 'shortcuts' folder
# and any icons in the 'icons' folder.

shopt -s globstar

[[ $(uname) != "Linux" ]] && exit 1 # skip if not running on Linux
[[ -x /usr/bin/wslinfo ]] && exit 1 # skip running on wsl

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
DOTFILES_PATH=${DOTFILES:-$(dirname "$SCRIPT_DIR")}

TARGET_APPLICATION_FOLDER=${XDG_DATA_HOME:-$HOME/.local/share}/applications
TARGET_SVG_FOLDER=${XDG_DATA_HOME:-$HOME/.local/share}/icons/hicolor/scaleable

[ ! -d "$TARGET_SVG_FOLDER/apps" ] && mkdir -p "$TARGET_SVG_FOLDER/apps"
[ ! -d "$TARGET_SVG_FOLDER/mimetypes" ] && mkdir -p "$TARGET_SVG_FOLDER/mimetypes"
[ ! -d "$TARGET_APPLICATION_FOLDER" ] && mkdir -p "$TARGET_APPLICATION_FOLDER"

function install_icon_file() {
    local SOURCE_FILE_PATH=$1
    FILE_BASENAME=$(basename "$SOURCE_FILE_PATH")
    ICON_CONTEXT=$2

    if [[ -z $ICON_CONTEXT ]]; then
        case "$SOURCE_FILE_PATH" in
            */apps/*) ICON_CONTEXT='apps';;
            */mimetypes/*) ICON_CONTEXT='mimetypes';;
            *)
                echo "Unknown icon context for \"$SOURCE_FILE_PATH\""
                return;;
        esac
    fi

    case "$SOURCE_FILE_PATH" in
        *.png)
        SOURCE_FILE_PNG_PATH="${SOURCE_FILE_PATH%.*}.png"
        ICON_SIZE=$(file -b "$SOURCE_FILE_PATH" | cut -d \  -f 4)
        xdg-icon-resource install --novendor --size "$ICON_SIZE" --context "$ICON_CONTEXT" "$SOURCE_FILE_PATH"
        ;;

        *.svg)
            cp "$SOURCE_FILE_PATH" "$TARGET_SVG_FOLDER/$ICON_CONTEXT"
            SOURCE_FILE_PNG_PATH="${SOURCE_FILE_PATH%.*}.png"
            if [[ ! -e "$SOURCE_FILE_PNG_PATH" ]]; then
                # convert the image from SVG to a PNG and intall the icon
                magick -background none "$SOURCE_FILE_PATH" -resize 256x256 "$SOURCE_FILE_PNG_PATH"

                if [[ -e "$SOURCE_FILE_PNG_PATH" ]]; then
                    ICON_SIZE=$(file -b "$SOURCE_FILE_PNG_PATH" | cut -d \  -f 4)
                    xdg-icon-resource install --novendor --size "$ICON_SIZE" --context "$ICON_CONTEXT" "$SOURCE_FILE_PNG_PATH"
                    rm "$SOURCE_FILE_PNG_PATH" >> /dev/null
                else
                    echo "Failed to Convert \"$SOURCE_FILE_PATH\" to \"$SOURCE_FILE_PNG_PATH\""
                fi
            fi
            ;;
    esac
}

for SOURCE_FILE_PATH in icons/apps/*.svg; do
    install_icon_file "$SOURCE_FILE_PATH" 'apps'
done

for SOURCE_FILE_PATH in icons/mimetypes/*.svg; do
    install_icon_file "$SOURCE_FILE_PATH" 'mimetypes'
done

for SOURCE_FILE_PATH in **/*.desktop; do
    FILE_BASENAME=$(basename "$SOURCE_FILE_PATH")

    case "$SOURCE_FILE_PATH" in
        *.desktop)
            TARGET_FILE_PATH="$TARGET_APPLICATION_FOLDER/$FILE_BASENAME"
            sed "s#\$DOTFILES/#$DOTFILES_PATH/#g" "$SOURCE_FILE_PATH" > "$TARGET_FILE_PATH"
            chmod 600 "$TARGET_FILE_PATH"
            echo "$SOURCE_FILE_PATH -> $TARGET_FILE_PATH"
            ;;
    esac
done

xdg-icon-resource forceupdate --mode user
xdg-desktop-menu forceupdate --mode user

exit 0
