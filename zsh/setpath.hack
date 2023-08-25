# # -*- mode: shell-script; -*-

export PATH="$HOME/bin:$HOME/.dotfiles/bin:/usr/local/bin:$PATH:/usr/local/sbin:/usr/sbin:/sbin:/usr/bin"

# Hack for OS X and homebrew paths for node and ruby
if [[ $(uname) == 'Darwin' ]]; then
	# add paths for these brew formulas
	brew_formulas=( "node" "ruby" )

	for formula in "${brew_formulas[@]}"
	do
		formula_bin_path="$(/usr/local/bin/brew --prefix $formula)"
		if [[ $? == 0 ]] then
		   export PATH="$formula_bin_path/bin:$PATH"
		fi
	done

	# add paths for latex
	if [[ -d "/usr/local/texlive/2014/bin/x86_64-darwin" ]]; then
	   export PATH="$PATH:/usr/local/texlive/2014/bin/x86_64-darwin"
	fi
fi

# Source RVM
if [ -d $HOME/.rvm/bin ]; then
	export PATH=$PATH:$HOME/.rvm/bin
	source $HOME/.rvm/scripts/rvm
elif [ -d /usr/local/rvm/bin ]; then
	export PATH=$PATH:/usr/local/rvm/bin
	source /usr/local/rvm/scripts/rvm
fi

if [ -d $HOME/.local/bin ]; then
	export PATH=$PATH:$HOME/.local/bin
fi

# Set the RaspberryPi Pico SDK path
if [ -d '/usr/share/pico-sdk' ]; then
	export PICO_SDK_PATH=/usr/share/pico-sdk
fi

