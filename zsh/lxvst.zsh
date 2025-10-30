# # -*- mode: shell-script; -*-

case "$OSTYPE" in
    linux*)
        # Set the LXVST path path
        [[ -d "$HOME/.local/lib/lxvst" ]] && export LXVST_PATH="$LXVST_PATH:$HOME/.local/lib/lxvst"
        ;;
esac
