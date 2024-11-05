# -*- mode: shell-script; -*-

[[ -f /etc/profile.d/fzf.zsh ]] && source /etc/profile.d/fzf.zsh
[[ -f /etc/profile.d/fzf-extras.zsh ]] && source /etc/profile.d/fzf-extras.zsh

if [ -x /usr/bin/fzf ]; then
    # Set up fzf key bindings and fuzzy completion
    source <(fzf --zsh)

    if [[ -n "$PS1" ]]; then
        # Catppuccin Frappé Theme
        export FZF_DEFAULT_OPTS=" \
--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
--color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
--color=marker:#babbf1,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284 \
--color=selected-bg:#51576d \
--multi"
    fi
fi
