# -*- mode: shell-script; -*-

# only do the following if running interactively
if [[ -n "$PS1" ]]; then
	alias reload!='. ~/.zshrc'

    case "$(uname)" in
		Linux | cygwin | CYGWIN*)
			alias ls='ls --color=auto'
			;;
	esac

	case "$(uname)" in
		Linux)
			alias open='xdg-open'
			;;
	esac
fi

alias edit='emacs-run'
