# only do the following if running interactively
if [[ -n "$PS1" ]]; then
	if [[ $OSTYPE == 'cygwin' ]]; then
		# bind HOME and END to beginning and end of line
		bindkey '\e[1~' beginning-of-line
		bindkey '\e[4~' end-of-line

		alias ls="ls --color=auto"

		# ignore dll files when autocompleting
		zstyle ':completion:*:complete:-command-:*' ignored-patterns '*.dll'
	fi
fi
