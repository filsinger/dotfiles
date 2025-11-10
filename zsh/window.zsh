# -*- mode: shell-script; -*-

# From http://dotfiles.org/~_why/.zshrc
# Sets the window title nicely no matter where you are
function title() {
  prefix=' '
  [[ -v SSH_TTY ]] && prefix=" SSH:"

  case $TERM in
  screen)
    print -Pn "\ek$a:$1\e\\" # screen title (in ^A")
    ;;
  tmux-direct)
    print -Pn "\033]2;$1\033\\"
    ;;
  xterm*|rxvt|alacritty)
    print -Pn "\e]2;$prefix $1\a" # plain xterm title ($3 for pwd)
    ;;
  esac
}
