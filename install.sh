sourced=
if [ "$0" = '-bash' ]; then
	sourced=1
fi

# Write absolute path of dotfiles dir into .dotfiles such that
# .bachrc and .bash_profile know where to init from.
DOTFILES_PATH="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd -P)"

echo "Installing dotfiles in dir '$DOTFILES_PATH' into $HOME/.dotfiles"
echo $DOTFILES_PATH > "$HOME/.dotfiles"

# Back up .bashrc and .bash_profile.
__backup() {
	if [ -f "$1" ]; then
		local bash_path=''
		while true; do
			echo -n "Enter backup path for '$1' (optional): "
			read input
			if [ "$input" = "$bash_path" ]; then
				break
			fi
			
			echo "Debug: Entered '$input'"
			
			# Confirmation of not backing up only happens
			# when other paths have been attempted.
			bash_path="$input"
			if [ -z "$bash_path" ]; then
				echo "Please repeat empty path to confirm not backing up '$1'"
				continue
			elif [ -a "$bash_path" ]; then
				echo "File '$bash_path' already exists. Please repeat path to confirm overwrite or enter another one."
				continue
			fi
			
			break
		done
		
		if [ -n "$bash_path" ]; then
			mv "$1" "$bash_path"
		else
			echo "Not backing up '$1'"
		fi
	fi
}

__backup "$HOME/.bashrc"
__backup "$HOME/.bash_profile"

echo 'Symlinking ~/.bashrc and ~/.bash_profile'

# Symlink .bashrc and .bash_profile into the ones in this folder.
ln -sf "$DOTFILES_PATH/bash/bashrc.sh" "$HOME/.bashrc"
ln -sf "$DOTFILES_PATH/bash/bash_profile.sh" "$HOME/.bash_profile"

# TODO Install non-bash dotfiles.

# OS/app-specific setup.

# Get OS name.
os=$(uname)

# Set hostname.
__set_hostname() {
	echo -n 'Set hostname (optional): '
	read input
	if [ -z "$input" ]; then
		echo 'Not setting hostname'
		return 0
	fi
	
	echo "Entering sudo mode to set hostname to '$input'"
	sudo echo 'OK'
	if [ $? -ne 0 ]; then
		echo "Not setting hostname"
		return 0
	fi
	
	case "$os" in
		'Darwin')
			sudo scutil --set HostName "$input"
			;;
		'Linux')
			sudo hostname "$input"
			;;
		*)
			>&2 echo "ERROR: Cannot set hostname on OS $os"
			;;
	esac
	
	return $?
}

__set_hostname

## Cannot source .bash_profile right away because install script isn't sourced
## (because that would break the resolution of DOTFILES_PATH).
## Give command for doing it instead.
#echo 'Open new terminal or run the following command:'
#echo ". $HOME/.bash_profile"

# Source .bash_profile right away.
echo "Sourcing .bash_profile"
source .bash_profile

#if [ "$sourced" ]; then
#	echo 'Installation complete. Please press ENTER to close terminal.'
#	read
#	exit
#fi
