#echo 'Processing bash_profile.sh'

DOTFILES_PATH="$(cat "$HOME/.dotfiles")"

# Allow dotfiles to introduce itself.
. "$DOTFILES_PATH/bash/init.sh"

# Include prompt settings.
. "$DOTFILES_PATH/bash/prompt.sh"

# Make history length unlimited.
export HISTFILESIZE=
export HISTSIZE=
