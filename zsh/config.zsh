if [[ -n $SSH_CONNECTION ]]; then
	PROMPT='%{$fg[magenta]%}%n@%m%{$fg[black]%}:%{$reset_color%}%1~ %{$fg[magenta]%}➤%{$reset_color%} '
else
	PROMPT='%{$fg[green]%}%m%{$fg[black]%}:%{$reset_color%}%1~ %{$fg[green]%}➤%{$reset_color%} '
fi
RPROMPT='$(git_info_for_prompt)'

## Shell colours
export LSCOLORS=exfxbxdxcxBxDxabagacad
export CLICOLOR=true
export TERM=xterm-256color

[[ -d /usr/local/share/zsh-completions ]] && fpath=(/usr/local/share/zsh-completions $fpath)
[[ -d $DOTFILES/zsh/functions ]] && fpath=($DOTFILES/zsh/functions $fpath)
[[ -d $DOTFILES/zsh/functions/ ]] && autoload -U $DOTFILES/zsh/functions/*(:t)
[[ -d $PRIVATE_DOTFILES/zsh/functions/ ]] && fpath=($PRIVATE_DOTFILES/zsh/functions $fpath)
[[ -d $PRIVATE_DOTFILES/zsh/functions/ ]] && autoload -U $PRIVATE_DOTFILES/zsh/functions/*(:t)

# only do the following if running interactively
if [[ -n "$PS1" ]]; then
	# History Information
	HISTFILE=~/.zsh_history
	HISTSIZE=1000
	SAVEHIST=1000
	REPORTTIME=10

	setopt NO_BG_NICE # don't nice background tasks
	setopt NO_HUP
	setopt NO_LIST_BEEP
	setopt LOCAL_OPTIONS # allow functions to have local options
	setopt LOCAL_TRAPS # allow functions to have local traps
	setopt HIST_VERIFY
	setopt SHARE_HISTORY # share history between sessions ???
	setopt EXTENDED_HISTORY # add timestamps to history
	setopt PROMPT_SUBST
	setopt CORRECT
	setopt COMPLETE_IN_WORD
	setopt IGNORE_EOF

	setopt APPEND_HISTORY # adds history
	setopt INC_APPEND_HISTORY SHARE_HISTORY  # adds history incrementally and share it across sessions
	setopt HIST_IGNORE_ALL_DUPS  # don't record dupes in history
	setopt HIST_REDUCE_BLANKS

	# don't expand aliases _before_ completion has finished
	#   like: git comm-[tab]
	setopt complete_aliases

	bindkey -e
	bindkey '^[[1;5C' forward-word
	bindkey '^[[1;5D' backward-word
	bindkey '^[^[[D' backward-word
	bindkey '^[^[[C' forward-word
	bindkey '^[[5D' beginning-of-line
	bindkey '^[[5C' end-of-line
	bindkey '^[[3~' delete-char
	bindkey '^[^N' newtab
	bindkey '^?' backward-delete-char

	zstyle ':completion:*' menu select
fi
