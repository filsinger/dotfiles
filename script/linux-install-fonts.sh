#!/usr/bin/env bash

[[ $(uname) != "Linux" ]] && exit 1 # skip if not running on Linux
[[ -x /usr/bin/wslinfo ]] && exit 1 # skip running on wsl

TARGET_FONT_DIRECTORY="$HOME/.local/share/fonts"
font_urls_to_install=(
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hack.zip"
)

function download_and_install_font_zip() {
    FONT_URL="$1"
    FONT_ZIP_FILE=$(basename "$FONT_URL")
    FONT_NAME=$(basename "${FONT_ZIP_FILE%.*}")

    echo "Installing Font: \"$FONT_NAME\" from \"$FONT_URL\""

    TEMP_FILE="/tmp/$FONT_NAME"
    TEMP_EXTRACTION_DIR="/tmp/FONT$FONT_NAME"
    if [[ ! -e "$TEMP_FILE" ]]; then
        curl -o "$TEMP_FILE" -L "$FONT_URL"
    fi

    if [[ -e "$TEMP_FILE" ]]; then
        unzip "$TEMP_FILE" -d "$TEMP_EXTRACTION_DIR" >> /dev/null
        mv -f "$TEMP_EXTRACTION_DIR"/*.ttf "$TARGET_FONT_DIRECTORY"
        rm -rf "$TEMP_EXTRACTION_DIR"
        rm "$TEMP_FILE"
    else
        echo "Failed to download and install \"$FONT_ZIP\""
    fi
}

echo "Installing Fonts To: $TARGET_FONT_DIRECTORY"
for font in "${font_urls_to_install[@]}"; do
    case $font in
        *.zip)
            download_and_install_font_zip "$font"
            ;;
        *)
            ;;
    esac
done

exit 0
