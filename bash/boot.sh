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

# ADD SCRIPT DIR TO PATH
export PATH="$PATH:$DOTFILES_PATH/bash/scripts"

# Include prompt settings.
source "$DOTFILES_PATH/bash/set-prompt.sh"

# TODO Move somewhere else.
if [ "$DOTFILES_BOOTER" = 'BASHPROFILE' ]; then
    # Make history length unlimited.
    export HISTFILESIZE=
    export HISTSIZE=
fi
