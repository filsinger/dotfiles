alias reload!='. ~/.zshrc'

unamestr=`uname`
if [[ "$unamestr" == "Linux" ]]; then
    alias ls='ls --color=auto'
elif [[ "$unamestr" == "Darwin" ]]; then

fi

