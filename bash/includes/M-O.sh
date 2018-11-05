# (Re)register M-O module.

reregister_MO() {
    # Call `unregister_MO` if it exists (i.e., unregister M-O if it's currenty registered).
    declare -f unregister_MO > /dev/null && unregister_MO

    # Set up environment.
    MO_LOG_LEVEL="$1"
    MO_PATH="$DOTFILES_PATH/modules/M-O"

    # Ensure that git submodule has been loaded (i.e. directory isn't empty).
    if [ -z "$(ls -A "$MO_PATH")" ]; then
        echo "Initializing M-O submodule"
        : $(
            cd "$MO_PATH" &&
            git submodule init &&
            git submodule update
        )
    fi

    # Load M-O with extensions.
    source "$MO_PATH/M-O.sh"

    # Register M-O.
    if [ "$DOTFILES_SHELL" = 'ZSH' ]; then
        source "$MO_PATH/register.zsh"
    else
        source "$MO_PATH/register.bash"
    fi
    source "$MO_PATH/actions/config-file-handler.sh"
    source "$MO_PATH/actions/default-handler.sh"
    source "$MO_PATH/actions/util.sh"
    source "$MO_PATH/actions/common.sh"
}

reregister_MO 0
