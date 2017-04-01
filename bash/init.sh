# Utility functions used by dotfiles to include the appropriate files.
# This file should be sourced exactly once.

# TODO Print depending on logging level set in env var DOTFILES_LOG_LEVEL.
#dotfiles_log() {
#}

#echo "Initializing dotfiles"

# Add script dir to path
export PATH="$PATH:$DOTFILES_PATH/bash/scripts"

# Reset PS1 in honor of dumb devices like Emacs Shell.
# It will be overwritten if .bash_profiles gets involved.
PS1='$ '

# Include aliases and functions.
for i in "$DOTFILES_PATH"/bash/includes/*.sh; do
    . "$i"
done
