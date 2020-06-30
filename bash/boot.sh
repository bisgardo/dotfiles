# VARIABLES ALREADY IN SCOPE [TODO VERIFY]: HOME, DOT_PATH, DOT_BOOTER.

# SETTINGS VARIABLES: DOT_OS, DOT_OS_DIST, DOT_OS_VERS

# Utility functions used by dotfiles to include the appropriate files.
# This file should be sourced exactly once.

# TODO Print depending on logging level set in env var DOTFILES_LOG_LEVEL.
#dotfiles_log() {
#}

#echo "Initializing dotfiles"

. "$DOTFILES_PATH/bash/set-vars-os.sh"

# Include aliases and functions in sorted order
# (sorting being guaranteed by bash).
source "$DOTFILES_PATH/bash/util.sh"
for include in "$DOTFILES_PATH"/bash/includes/*.sh; do
    source "$include"
done

# ADD SCRIPT AND LOCAL BIN DIRS TO PATH.
export PATH="$HOME/bin:$DOTFILES_PATH/bash/bin:$PATH"

# Include prompt settings.
source "$DOTFILES_PATH/bash/set-prompt.sh"

# TODO Move somewhere else.
if [ "$DOTFILES_BOOTER" = 'BASHPROFILE' ]; then
	# Make history length unlimited.
	export HISTFILESIZE=
	export HISTSIZE=
fi

# TODO Move somewhere else.
# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
#  elif [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
  fi
fi

# TODO: Duplicated from M-O (because bash-completion overrides it).
function quote() {
	local p
	for v in "$@"; do
		local q="${v//\'/\'\\\'\'}"
		printf "$p'%s'" "$q"
		p=' '
	done
}
