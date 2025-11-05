#!/usr/bin/env bash

KONSOLE_SHARE_FOLDER="$HOME/.local/share/konsole"

function download_theme_file_to_folder() {
    THEME_URL="$1"
    THEME_TARGET_FOLDER="$2"
    THEME_FILENAME=$(basename "$THEME_URL")
    [[ ! -d "$THEME_TARGET_FOLDER" ]] && mkdir -p "$THEME_TARGET_FOLDER"
    [[ ! -e "$THEME_TARGET_FOLDER/$THEME_FILENAME" ]] && curl "$THEME_URL" -o "$THEME_TARGET_FOLDER/$THEME_FILENAME"
}

case $DESKTOP_SESSION in
    plasma)
        # Install catppuccin-frappe theme for Konsole
        download_theme_file_to_folder \
            'https://raw.githubusercontent.com/catppuccin/konsole/refs/heads/main/themes/catppuccin-frappe.colorscheme' \
            "$KONSOLE_SHARE_FOLDER"

        # Create a Profile for Konsole that uses catppuccin frappe
        if [[ -e "$KONSOLE_SHARE_FOLDER/catppuccin-frappe.colorscheme" ]]; then
            {
                echo '[Appearance]'
                echo 'ColorScheme=catppuccin-frappe'
                echo ''
                echo '[General]'
                echo 'Environment=TERM=xterm-direct,COLORTERM=truecolor'
                echo 'Name=Catppuccin Frappe'
                echo 'Parent=FALLBACK/'
            }  > "$KONSOLE_SHARE_FOLDER/Catppuccin Frappe.profile"
        fi

        ;;
esac

exit 0
