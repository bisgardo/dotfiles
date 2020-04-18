echo "Processing bashrc.sh (previous booter: $DOTFILES_BOOTER)"

# [TODO VERIFY THAT $HOME IS DEFINED]

# LOAD PATH OF DOTFILES FROM `.dotfiles`.
DOTFILES_PATH="$(cat "$HOME/.dotfiles")"

# SET INITIATOR VARIABLE AND BOOT DOTFILES
DOTFILES_SHELL='BASH'
export DOTFILES_BOOTER='BASHRC'
source "$DOTFILES_PATH/bash/boot.sh"
