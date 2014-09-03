# -*- mode: shell-script; -*-

# only do the following if running interactively
if [[ -n "$PS1" ]]; then
	alias reload!='. ~/.zshrc'

    case "$(uname)" in
		Linux | cygwin | CYGWIN*)
			alias ls='ls --color=auto'
		;;
	esac
fi

alias edit='emacs-run'
