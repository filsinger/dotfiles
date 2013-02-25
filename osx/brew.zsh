if [[ $(uname) == 'Darwin' ]] then
	# add paths for these brew formulas
	brew_formulas=( "node" "ruby" )

	for formula in "${brew_formulas[@]}"
	do
		formula_bin_path="$(brew --prefix $formula)"
		if [[ $? == 0 ]] then
			export PATH="$formula_bin_path/bin:$PATH"
		fi
	done
fi
