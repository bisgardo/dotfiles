# SET OS KERNEL, DISTRIBUTION, AND VERSION VARIABLES:
# * KERNEL:
#   - *X: A variant of Unix
#   - Linux: LINUX
#   - Mac: OSX
#   - Windows: WIN
export DOTFILES_OS=
# * DISTRIBUTION:
#  - Linux: UBUNTU, ...
#  - Windows: MINGW, CYGWIN
export DOTFILES_OS_DIST=
# SET OS (DISTRIBUTION) VERSION VARIABLE:
# - Version of Windows: 7, 8, 10
# - Version of OSX/MacOS: 10.10, ...
# - Version of Ubuntu: 14.04, 16.04, ...
export DOTFILES_OS_VERS=

_set_os_vars() {
	local -r os="$1"
	# SET `DOT_OS_*` VARIABLES [TODO Fall back to uname?]
	case "$os" in
		linux*)
			DOTFILES_OS=LINUX
			if [ -f /etc/os-release ]; then
				local ID
				local VERSION_ID
				source /etc/os-release
				
				# Reset variables set by the command
				# (converted to upper case - requires bash 4+).
				DOTFILES_OS_DIST="${ID^^}"
				DOTFILES_OS_VERS="${VERSION_ID^^}"
			elif [ -f /etc/lsb-release ]; then
				local DISTRIB_ID
				local DISTRIB_RELEASE
				source /etc/lsb-release
				
				# Reset variables set by the command
				# (converted to upper case - requires bash 4+).
				DOTFILES_OS_DIST="${DISTRIB_ID^^}"
				DOTFILES_OS_VERS="${DISTRIB_RELEASE^^}"
			fi
			# TODO Support other (legacy) release files just for insanity's sake: http://linuxmafia.com/faq/Admin/release-files.html
			;;
		darwin*)
			DOTFILES_OS=OSX
			;;
		win*) # [TODO Verify]
			DOTFILES_OS=WIN
			;;
		cygwin*) # [TODO Verify]
			DOTFILES_OS=WIN
			DOTFILES_OS_DIST=CYGWIN
			;;
		msys*) # [TODO Verify]
			DOTFILES_OS=WIN
			DOTFILES_OS_DIST=MINGW
			;;
	esac
}

# OSTYPE is usually set by bash.
_set_os_vars "$OSTYPE"
