# -*- mode: shell-script; -*-

# only do the following if running interactively
if [[ -n "$PS1" ]]; then
	if [[ $OSTYPE == 'cygwin' ]]; then
		# bind HOME and END to beginning and end of line
		bindkey '\e[1~' beginning-of-line
		bindkey '\e[4~' end-of-line

		# ignore dll files when autocompleting
		zstyle ':completion:*:complete:-command-:*' ignored-patterns '*.dll'

		if [[ -e "$(cygpath "C:\Program Files\Perforce\p4.exe")" ]]; then
			function p4() {
				export PWD=`cygpath -wa .`
				"$(cygpath "C:\Program Files\Perforce\p4.exe")" $@
			}
		fi
	fi
fi
