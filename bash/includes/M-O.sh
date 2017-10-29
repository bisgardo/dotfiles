# Register M-O.

reregister_MO() {
    type -t unregister_MO > /dev/null && unregister_MO
    
    MO_LOG_LEVEL="$1"
    MO_PATH="$DOTFILES_PATH/modules/M-O"
    
    if [ -z "$(ls -A "$MO_PATH")" ]; then
        echo "Initializing M-O submodule"
        : $(
            cd "$MO_PATH" &&
            git submodule init &&
            git submodule update
        )
    fi
    
    command source "$MO_PATH/M-O.sh"
    command source "$MO_PATH/register.bash"
    command source "$MO_PATH/extensions.sh" # Optional; see below.
}

reregister_MO 0
