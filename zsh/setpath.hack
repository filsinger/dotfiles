# # -*- mode: shell-script; -*-

[[ -d "$HOME/.dotfiles/bin" ]] && export PATH="$HOME/.dotfiles/bin:$PATH"
[[ -d "$HOME/.private.dotfiles/bin" ]] && export PATH="$HOME/.private.dotfiles/bin:$PATH"
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/.local/bin/private" ]] && export PATH="$HOME/.local/bin/private:$PATH"

case "$OSTYPE" in
    darwin*)
        # Hack for OS X and homebrew paths for node and ruby

	    # add paths for these brew formulas
	    brew_formulas=( "node" "ruby" )

	    for formula in "${brew_formulas[@]}"
	    do
            [[ -x '/usr/local/bin/brew' ]] && formula_bin_path="$(/usr/local/bin/brew --prefix $formula)"
		    [[ -x '/opt/homebrew/bin/brew' ]] && formula_bin_path="$(/opt/homebrew/bin/brew --prefix $formula)"

		    if [[ $? == 0 ]] then
		       export PATH="$formula_bin_path/bin:$PATH"
		    fi
	    done
        ;;

    linux*)
        if [[ -x /usr/bin/wslinfo ]]; then
            # Add any WSL paths
            [[ -d '/mnt/c/bin' ]] && export PATH="$PATH:/mnt/c/bin"
        fi
        ;;

esac

# Source RVM
if [ -d "$HOME/.rvm/bin" ]; then
	export PATH="$PATH:$HOME/.rvm/bin"
	source "$HOME/.rvm/scripts/rvm"
elif [ -d '/usr/local/rvm/bin' ]; then
	export PATH="$PATH:/usr/local/rvm/bin"
	source "/usr/local/rvm/scripts/rvm"
fi
