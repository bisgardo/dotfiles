# SET OS KERNEL, DISTRIBUTION, AND VERSION VARIABLES:
# * KERNEL:
#   - *X: A variant of Unix
#   - Linux: LINUX
#   - Mac: OSX
#   - Windows: WIN
DOTFILES_OS=
# * DISTRIBUTION:
#  - Linux: UBUNTU, ...
#  - Windows: MINGW, CYGWIN
DOTFILES_OS_DIST=
# SET OS (DISTRIBUTION) VERSION VARIABLE:
# - Version of Windows: 7, 8, 10
# - Version of OSX/MacOS: 10.10, ...
# - Version of Ubuntu: 14.04, 16.04, ...
DOTFILES_OS_VERS=

# SET `DOT_OS_*` VARIABLES [TODO Fall back to uname?]
case "$OSTYPE" in
    linux*)
	DOTFILES_OS=LINUX
	if [ -f /etc/lsb-release ]; then
	    . /etc/lsb-release

	    # Reset variables set by the command
	    # (converted to upper case - requires bash 4+).
	    DOTFILES_OS_DIST="${DISTRIB_ID^^}"
	    DOTFILES_OS_VERS="${DISTRIB_RELEASE^^}"
	fi
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
