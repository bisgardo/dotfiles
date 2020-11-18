# Bail if noninteractive shell
# (such as 'scp'; see 'https://unix.stackexchange.com/q/154395/129308').
[ -z "$PS1" ] && return

echo "Processing bashrc.sh (previous booter: $DOTFILES_BOOTER)"

# [TODO VERIFY THAT $HOME IS DEFINED]

# LOAD PATH OF DOTFILES FROM `.dotfiles`.
DOTFILES_PATH="$(cat "$HOME/.dotfiles")"

# SET INITIATOR VARIABLE AND BOOT DOTFILES
DOTFILES_SHELL='BASH'
export DOTFILES_BOOTER='BASHRC'
source "$DOTFILES_PATH/bash/boot.sh"
