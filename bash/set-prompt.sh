# Reset PS1 in honor of dumb devices like Emacs Shell.
if [ "$DOTFILES_BOOTER" != 'BASHPROFILE' -a "$DOTFILES_OS_DIST" != 'UBUNTU' ]; then
    PS1='$ '
    return
fi

__dotfiles_print_ok() {
    local x=$?
    if [ $x -eq 0 ]; then
	printf "[0] "
    fi
    return $x
}

__dotfiles_print_error_code() {
    local x=$?
    if [ $x -ne 0 ]; then
	printf "[$x] "
    fi
    return $x
}

__dotfiles_git_ps1() {
    [ -n "$(type -t __git_ps1)" ] && __git_ps1 "$1"
}

__dotfiles_pwd_ps1() {
    if [ -f "$PWD/.ps1" ]; then
	cat "$PWD/.ps1"
    fi
}

__dotfiles_dir_enter_recursive() {
    # TODO This function should be implementable as a loop?
    
    local dir="$1"
    local root="$2"
    
    # TODO Should check that $root is a prefix of $dir to prevent
    #      infinite looping (and otherwise ensure correctness).
    
    if [ "$dir" = "$root" ]; then
	return
    fi
    
    local subdir=
    if [ "$dir" != '/' ]; then
	subdir="$(dirname "$dir")"
    fi
    
    __dotfiles_dir_enter_recursive "$subdir" "$root"
    
    #echo "DEBUG: Entering $dir"
    if [ -f "$dir/.dir" ]; then
	local onEnter
	source "$dir/.dir"
	if [ -n "$onEnter" ]; then
	    echo "Entering $dir: $onEnter"
	    eval $onEnter # No quotes!
	fi
    fi
}

# The directory that was the current directory the last time that
# `__dotfiles_prompt_command` was called, with symlinks resolved.
export DOTFILES_PREV_DIR=
__dotfiles_dir_update() {
    # TODO Should be global?
    local workdir="$(pwd -P)"
    
    if [ -z "$DOTFILES_PREV_DIR" ]; then
	# Shell was just opened. "Enter" all the way from '/' (inclusive).
	__dotfiles_dir_enter_recursive "$workdir" ''
	DOTFILES_PREV_DIR="$workdir"
	return
    fi
    
    # 0. Let CAD be the "deepest" common ancestor directory of
    #    $workdir and $DOTFILES_PREV_DIR (with symlinks resolved).
    # 1. Call "leave" functions from $DOTFILES_PREV_DIR to CAD.
    
    local dir="$DOTFILES_PREV_DIR"
    
    # Loop upwards in directory tree until "$dir/" is a prefix of "$workdir/".
    # Slashes are necessary for matching full path components.
    # The check doesn't work if $dir is '/', in which case there's also no leaving to do.
    if [ "$dir" != '/' ]; then
	local workdirs="$workdir/"
	while [ "${workdirs#$dir/}" = "$workdirs" ]; do
	    #echo "DEBUG: Leaving $dir"
	    if [ -f "$dir/.dir" ]; then
		local onDirLeave
		source "$dir/.dir"
		if [ -n "$onLeave" ]; then
		    echo "Leaving $dir: $onLeave"
		    eval $onLeave # No quotes!
		fi
	    fi
	    
	  dir="$(dirname "$dir")"
	  #sleep 1
	done
    fi
    
    # 2. Call "enter" functions from CAD (which now equals $dir) down to $workdir.
    __dotfiles_dir_enter_recursive "$workdir" "$dir"
    DOTFILES_PREV_DIR="$workdir"
}

__dotfiles_prompt_command() {
    __dotfiles_dir_update
}

__dotfiles_set_prompt() {
    local PS1_COLOR_LIGHT_GRAY='\[\e[0;37m\]'
    local PS1_COLOR_GREEN='\[\e[0;32m\]'
    local PS1_COLOR_BOLD_RED='\[\e[1;31m\]'
    local PS1_COLOR_YELLOW='\[\e[0;33m\]'
    local PS1_COLOR_BOLD='\[\e[1m\]'
    local PS1_COLOR_RESET='\[\e[0m\]'
    
    #local PS1_TITLE='\[\e]0;\u@\H (\d)\a\]'
    local PS1_STATUS=$PS1_COLOR_GREEN'$(__dotfiles_print_ok)'$PS1_COLOR_BOLD_RED'$(__dotfiles_print_error_code)'$PS1_COLOR_RESET
    local PS1_DIR=$PS1_COLOR_LIGHT_GRAY'\w'$PS1_COLOR_RESET
    #local PS1_HOST='\h'
    local PS1_GIT_BRANCH=$PS1_COLOR_YELLOW'$(__dotfiles_git_ps1 " (%s)")'$PS1_COLOR_RESET
    local PS1_MARKER=$PS1_COLOR_BOLD' \$'$PS1_COLOR_RESET
    local PS1_PWD='$(__dotfiles_pwd_ps1)'
    
    # Set prompt.
    export PS1="$PS1_PWD$PS1_LS$PS1_STATUS$PS1_DIR$PS1_GIT_BRANCH$PS1_MARKER "
    export PROMPT_COMMAND=__dotfiles_prompt_command
}

__dotfiles_set_prompt
