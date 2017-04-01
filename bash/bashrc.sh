#echo 'Processing bashrc.sh'

# Load path of dotfiles from .dotfiles.
DOTFILES_PATH="$(cat "$HOME/.dotfiles")"

# Allow dotfiles to introduce itself.
. "$DOTFILES_PATH/bash/init.sh"
