# MODULE FUNCTIONS #

__dirs_enter_dir() {
    local dir="${1%/}"
    
    #echo "DEBUG: Entering $dir"
    if [ -f "$dir/.dir" ]; then
        # Exposed variables (must declare unused ones to prevent them from
        # being set in the global scope).
        local onEnter
        local onLeave
        command source "$dir/.dir"
        if [ -n "$onEnter" ]; then
            echo "Entering $dir: $onEnter"
            command eval $onEnter # No quotes!
        fi
    fi
}

__dirs_leave_dir() {
    local dir="${1%/}"
    
    #echo "DEBUG: Leaving $dir"
    if [ -f "$dir/.dir" ]; then
        # Exposed variables (must declare unused ones to prevent them from
        # being set in the global scope).
        local onEnter
        local onLeave
        command source "$dir/.dir"
        if [ -n "$onLeave" ]; then
            echo "Leaving $dir: $onLeave"
            command eval $onLeave # No quotes!
        fi
    fi
}

__dirs_is_ancestor() {
    # Ensure trailing slash (necessary for prefix check to be correct).
    local ancestor="${1%/}/"
    local descendant="${2%/}/"
    
    # $descendant with the (literal) prefix $ancestor removed.
    local suffix="${descendant#"$ancestor"}"
    
    # If $ancestor is a (non-empty) prefix, then
    # $suffix will be different from $descendant.
    [ "$suffix" != "$descendant" ]
}

# The directory that was the current directory the last time that
# `__dirs_update` was called, with symlinks resolved.
export DIRS_PREV_DIR=

__dirs_update() {
    local x=$?
    
    # Strip any trailing slash of arg (incl. of '/').
    local DIRS_CUR_DIR="${1%/}"
    
    # Simple case.
    if [ "$DIRS_PREV_DIR" = "$DIRS_CUR_DIR" ]; then
        return $x
    fi
    
    # Traverse from $DIRS_PREV_DIR up the tree until $dir is an ancestor of
    # $DIRS_CUR_DIR (i.e. a prefix), "leaving" directories on the way.
    local dir="$DIRS_PREV_DIR"
    until __dirs_is_ancestor "$dir" "$DIRS_CUR_DIR"; do
        __dirs_leave_dir "$dir"
        
        dir="$(dirname "$dir")"
        if [ "$dir" = '/' ]; then
            dir=
        fi
    done
    
    # Relative path from $dir to $DIRS_CUR_DIR.
    local path="${DIRS_CUR_DIR#"$dir"}"
    
    # Split $path (with any leading '/' removed) on '/' into $dirs.
    IFS='/' command read -r -a dirs <<< "${path#/}"
    
    for d in "${dirs[@]}"; do
        dir="$dir/$d"
        
        __dirs_enter_dir "$dir"
    done
    
    DIRS_PREV_DIR="$DIRS_CUR_DIR"
    
    return $?
}

# REGISTER FUNCTIONS #

__dirs_prompt_command() {
    __dirs_update "$(pwd -P)"
}

__dirs_register() {
    export PROMPT_COMMAND="__dirs_prompt_command;$PROMPT_COMMAND"
}
