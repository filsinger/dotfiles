# only do the following if running interactively
if [[ -n "$PS1" ]]; then
	alias reload!='. ~/.zshrc'

	unamestr=`uname`
	if [[ "$unamestr" == "Linux" ]]; then
		alias ls='ls --color=auto'
	elif [[ "$unamestr" == "Darwin" ]]; then

	fi
fi

alias edit='emacs-run'
