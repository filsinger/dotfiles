# -*- mode: shell-script; -*-

[[ -f /etc/profile.d/fzf.zsh ]] && source /etc/profile.d/fzf.zsh
[[ -f /etc/profile.d/fzf-extras.zsh ]] && source /etc/profile.d/fzf-extras.zsh

# Set up fzf key bindings and fuzzy completion
[[ -x /usr/bin/fzf ]] && source <(fzf --zsh)
