# -*- mode: shell-script; -*-

# Add the proxy icon in the Terminal titlebar on OSX
#
# This idea came from here: http://hints.macworld.com/article.php?story=20110722211753852
#

if [ "$TERM_PROGRAM" = "Apple_Terminal" ] && [ -z "$INSIDE_EMACS" ]; then
    update_terminal_cwd() {
        # Identify the directory using a "file:" scheme URL,
        # including the host name to disambiguate local vs.
        # remote connections. Percent-escape spaces.
        local SEARCH=' '
        local REPLACE='%20'
        local PWD_URL="file://$HOST${PWD//$SEARCH/$REPLACE}"
        printf '\e]7;%s\a' "$PWD_URL"
    }
    autoload add-zsh-hook
    add-zsh-hook chpwd update_terminal_cwd
    update_terminal_cwd
fi
