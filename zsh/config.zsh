# -*- mode: shell-script; -*-

## Shell colours
export LSCOLORS=exfxbxdxcxBxDxabagacad
export CLICOLOR=true

[[ -d $DOTFILES/zsh/functions ]] && fpath=($DOTFILES/zsh/functions $fpath)
[[ -d $DOTFILES/zsh/functions/ ]] && autoload -U $DOTFILES/zsh/functions/*(:t)
[[ -d $PRIVATE_DOTFILES/zsh/functions/ ]] && fpath=($PRIVATE_DOTFILES/zsh/functions $fpath)
[[ -d $PRIVATE_DOTFILES/zsh/functions/ ]] && autoload -U $PRIVATE_DOTFILES/zsh/functions/*(:t)

# only do the following if running interactively
if [[ -n "$PS1" ]]; then
	if [[ -n $SSH_CONNECTION ]]; then
		PROMPT='%{$fg[magenta]%}%n@%m%{$fg[black]%}:%{$reset_color%}%1~ %{$fg[magenta]%}❯%{$reset_color%} '
	else
		if [[ -n $TMUX ]]; then
			PROMPT='%{$fg[blue]%}%m%{$fg[black]%}:%{$reset_color%}%1~ %{$fg[blue]%}❯%{$reset_color%} '
		else
			PROMPT='%{$fg[green]%}%m%{$fg[black]%}:%{$reset_color%}%1~ %{$fg[green]%}❯%{$reset_color%} '
		fi
	fi

	autoload -Uz vcs_info
	zstyle ':vcs_info:*' enable git hg
	zstyle ':vcs_info:*' check-for-changes true
	zstyle ':vcs_info:*' stagedstr '%F{240}| %F{40}•%f '
	zstyle ':vcs_info:*' unstagedstr '%F{240}| %F{214}•%f '
	zstyle ':vcs_info:git*' formats "%F{240}[%f %b %m%u%c%F{240}]%f"
	zstyle ':vcs_info:*' actionformats '%F{240}[%f %b %m%u%c%F{240}|%f %a %F{240}]%f'

	function precmd() {
		vcs_info
	}

	RPROMPT='${vcs_info_msg_0_}'

	[[ -d /usr/local/share/zsh-completions ]] && fpath=(/usr/local/share/zsh-completions $fpath)

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

	autoload -z edit-command-line
	zle -N edit-command-line
	bindkey "^X^E" edit-command-line

	zstyle ':completion:*' menu select

	# online help
	if [ -d '/usr/local/share/zsh/helpfiles' ]; then
		unalias run-help
		autoload run-help
		HELPDIR=/usr/local/share/zsh/helpfiles
	fi
fi
