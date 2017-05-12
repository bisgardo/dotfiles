__dirs_enter_dir() {
    local dir="$1"
    
    #echo "DEBUG: Entering $dir"
    # TODO Extract function
    if [ -f "$dir/.dir" ]; then
        local onEnter
        source "$dir/.dir"
        if [ -n "$onEnter" ]; then
            echo "Entering $dir: $onEnter"
            eval $onEnter # No quotes!
        fi
    fi
}

__dirs_leave_dir() {
    local dir="$1"
    
    #echo "DEBUG: Leaving $dir"
    if [ -f "$dir/.dir" ]; then
        # Exposed variables (must declare unused ones to prevent them from
        # being set in the global scope).
        local onDirEnter
        local onDirLeave
        source "$dir/.dir"
        if [ -n "$onLeave" ]; then
            echo "Leaving $dir: $onLeave"
            eval $onLeave # No quotes!
        fi
    fi
}

# The directory that was the current directory the last time that
# `__dirs_update` was called, with symlinks resolved.
export DIRS_PREV_DIR=
__dirs_update() {
    # Strip any trailing slash.
    local DIRS_CUR_DIR="${1%/}"
    
    # Simple case.
    if [ "$DIRS_PREV_DIR" = "$CUR_PREV_DIR" ]; then
        return
    fi
    
    #echo "from '$DIRS_PREV_DIR' to '$DIRS_CUR_DIR'"
    
    # Traverse from $DIRS_PREV_DIR up the tree until $dir is an ancestor of
    # $DIRS_CUR_DIR (i.e. a prefix), "leaving" directories on the way.
    local dir="$DIRS_PREV_DIR"
    until is_prefix "$dir/" "$DIRS_CUR_DIR/"; do
        __dirs_leave_dir "$dir"
        
        dir="$(dirname "$dir")"
        if [ "$dir" = '/' ]; then
            dir=
        fi
    done
    
    # Relative path from $dir to $DIRS_CUR_DIR.
    local path="${DIRS_CUR_DIR#"$dir"}"
    #echo "dir=$dir, path=$path"
    
    # Split $path (with any leading '/' removed) on '/' into $dirs.
    IFS='/' read -r -a dirs <<< "${path#/}"
    
    for d in "${dirs[@]}"; do
        dir="$dir/$d"
        
        __dirs_enter_dir "$dir"
    done
    
    DIRS_PREV_DIR="$DIRS_CUR_DIR"
}
