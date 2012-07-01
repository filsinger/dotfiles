# This fixes a problem where tramp hangs when trying to
# edit a remote file in emacs using tramp.
#
# via: http://emacswiki.org/emacs/TrampMode#toc6
#

if [[ "$TERM" == "dumb" ]]
then
  unsetopt zle
  unsetopt prompt_cr
  unsetopt prompt_subst
  unfunction precmd
  unfunction preexec
  PS1='$ '
fi
