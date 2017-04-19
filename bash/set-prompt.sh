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
    # TODO Search entire ancesor path.
    if [ -f "$PWD/.ps1" ]; then
	. "$PWD/.ps1"
    fi
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
    #export PROMPT_COMMAND=
}

__dotfiles_set_prompt
