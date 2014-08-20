#!/bin/bash

script_time_start=$(date +%s)

pushd $(dirname $0)/.. > /dev/null
dotfiles_path="$(PWD)"
dotfiles_backup_path="$dotfiles_path/.backup"
popd > /dev/null

function print_title {
	printf "\e[36m==>\e[0m \e[1m$1\e[0m\n"
}

function get_platform {
	case $(uname) in
		Darwin)
			echo osx
			;;
		cygwin | CYGWIN*)
			echo cygwin
			;;
		Linux)
			echo linux
			;;
	esac
}

function check_for_package {
	output=$(which $1)
	if [ $? == 0 ]; then
	   return 1
	fi
	return 0
}

function install_brew() {
	if [[ $(get_platform) == 'osx' ]]; then
		print_title 'Installing Homebrew'

	   if [[ $(check_for_package "brew") == '0' ]]; then
		   echo -n "installing homebrew..."
		   output=$(ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)")
		   echo "done"
	   else
		   echo "homebrew already installed"
	   fi
	fi
}

function install_package {
	case $(get_platform) in
		osx)
			brew install $1
			;;
		*)
			;;
	esac
}

function install_packages()
{
	print_title 'Installing Packages'

	package_list_common="zsh git tmux curl emacs wget"
	package_list_osx=$package_list_common" gnu-sed"
	package_list_linux=$package_list_common" "
	package_list_cygwin=$package_list_common" "
	package_list=""
	case $(get_platform) in
	    osx)
			package_list=$package_list_osx
			;;
		cygwin | CYGWIN*)
			package_list=$package_list_cygwin
			;;
		*)
			;;
	esac

	for p in $package_list; do
		install_package $p
	done
	echo "done"
}

function get_dotfile_symlink_target_name {
	filename_base=$(basename $1)
	echo ".${filename_base%.symlink*}"
}

function get_dotfile_copyfile_target_name {
	filename_base=$(basename $1)
	echo ".${filename_base%.copyfile*}"
}


function backup_file {
	if [ ! -d "$dotfiles_backup_path" ]; then
		mkdir -p "$dotfiles_backup_path"
	fi

	file_to_backup="$1"
	backup_file="$dotfiles_backup_path/backup$(basename $file_to_backup)"
	if [ -e "$file_to_backup" ]; then
		if [ -d "$dotfiles_backup_path" ]; then
			printf "[\e[34mbacking up\e[0m]: $file_to_backup \e[90m->\e[0m $backup_file\n"
			mv -f "$file_to_backup" "$backup_file"
			if [ $? -ne 0 ]; then
				echo "backup failed"
				exit 1
			fi
		fi
	fi
}

function link_symlinks {
	# build a list of all files to symlink
	dotfile_platform_suffix=$(get_platform)
	dotfiles_to_link="$(find $dotfiles_path -name '*.symlink') $(find $dotfiles_path -name *.symlink.$dotfile_platform_suffix)"

	if [[ $dotfiles_to_link != " " ]]; then
		print_title 'Linking Symlinks'

		# symlink the dotfiles
		for source_file in $dotfiles_to_link; do
			target_file="$HOME/$(get_dotfile_symlink_target_name $source_file)"
			backup_file="$dotfiles_backup_path/backup$(basename $target_file)"
			if [ -L "$target_file" ]; then
				printf "[\e[33mskipping\e[0m] \e[0m$(basename $source_file)\e[0m \e[90m->\e[0m ~/\e[0m$(basename $target_file)\e[0m\n"
			else
				backup_file "$target_file"
				printf "[\e[32mlinking\e[0m] \e[0m$(basename $source_file)\e[0m \e[90m->\e[0m ~/\e[0m$(basename $target_file)\e[0m\n"
				#printf "[\e[32mlinking\e[0m]  $(basename $source_file) -> ~/$(basename $target_file)\n"
				ln -s "$source_file" "$target_file"
			fi
		done
	fi
}

function copy_copyfiles {
	dotfile_platform_suffix=$(get_platform)
	dotfiles_to_copy="$(find $dotfiles_path -name '*.copyfile') $(find $dotfiles_path -name *.copyfile.$dotfile_platform_suffix)"

	if [[ $dotfiles_to_copy != " " ]]; then
		print_title 'Copying Hard Files'

		for source_file in $dotfiles_to_copy; do
			target_file="$HOME/$(get_dotfile_copyfile_target_name $source_file)"
			backup_file="$dotfiles_backup_path/backup$(basename $target_file)"
			# if [ -a "$target_file" ]; then
			# 	echo "[skipping] $(basename $source_file) -> ~/$(basename $target_file)"
			# else
				backup_file "$target_file"
				echo "[copying] $(basename $source_file) -> ~/$(basename $target_file)"
				cp -f "$source_file" "$target_file"
			#fi
		done
	fi
}

function clean_symlinks {
	print_title 'Cleaning Symlinks'
	# remove dead links
	for link_file in $(find "$HOME" -name ".*" -type l -maxdepth 1); do
		target_file="$(readlink $link_file)"
		if [ ! -e "$(readlink $link_file)" ]; then
			echo "[removing] ~/$(basename $link_file) -> $target_file"
			rm "$link_file"
		fi
	done
	echo "done"
}

function unlink_symlinks {
	print_title 'Unlinking Symlinks'
	# FIXME: Implement this
	printf "[\e[31munimplemented\e[0m] unlink_symlinks isnt implemented\n"
}

function print_summary {
	print_title 'Summary'
	script_time_end=$(date +%s)
	runtime=$((script_time_end-script_time_start))
	printf "$(basename $0) executed in $runtime seconds\n"
}

function print_usage {
	printf "Example usage:\n"
	printf "  $(basename $0) [\e[4moption\e[0m]\n"
	printf "\n"
	printf "Options:\n"
	printf "  install    install system packages\n"
	printf "  link       link all .symlink files into '$HOME/'\n"
	printf "  unlink     unlink all .symlink files in '$HOME/' and restore from backup\n"
	printf "  clean      remove any dead symlinks in '$HOME/'\n"
	printf "\n"
}

case "$1" in
	'install')
		install_brew
		install_packages
		print_summary
		;;
	'link')
		link_symlinks
	    copy_copyfiles
		print_summary
		;;
	'unlink')
		unlink_symlinks
		print_summary
		;;
	'clean')
		clean_symlinks
		print_summary
		;;
	*)
		print_usage
		;;
esac

exit 0
