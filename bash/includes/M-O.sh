# Register M-O.

reregister_M-O() {
    type -t unregister_M-O > /dev/null && unregister_M-O
    
    MO_LOG_LEVEL="$1"
    MO_PATH="$HOME/Documents/Projects/M-O"
    
    source "$MO_PATH/M-O.sh"
    source "$MO_PATH/register.bash"
    source "$MO_PATH/extensions.sh" # Optional; see below.
}

reregister_M-O
