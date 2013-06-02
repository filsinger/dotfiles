# Add RVM to PATH for scripting
if [ -d $HOME/.rvm/bin ]
then
   export PATH=$PATH:$HOME/.rvm/bin
   source $HOME/.rvm/scripts/rvm
elif [ -d /usr/local/rvm/bin ]
then
   export PATH=$PATH:/usr/local/rvm/bin
   source /usr/local/rvm/scripts/rvm
fi
