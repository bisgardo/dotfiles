# Replace `cat` and `cd` with enhanced versions. Let `cd .` be interpreted as
# "change directory to dir of last file that was `cat`'ed"
alias __cat="$(which cat)"
cat() {
    # TODO Verify that this expands args with spaces in them correctly.
    __cat $@
    __CAT_DIR="$(dirname "$1")"
}

cd() {
    if [ "$1" = '.' -a -n "$__CAT_DIR" ]; then
        command cd "$__CAT_DIR"
        #unset __CAT_DIR
        return
    fi
    command cd $@
}

alias cd.='cd .'

# TODO Consider replacing all of `cd..`, `cl..`, and `c..` with just `..`
#      (or letting them take no arguments).

# Prints path of ancestor folder n levels up.
..() {
    for i in $(seq 1 $1); do
        printf '../'
    done
}

# TODO Make it possible to give pattern instead of number. Changes directory to
#      closest ancestor that matches pattern. Commands should also support
#       autocomplete.

# TODO Can make command for listing subdirectories matching a pattern and then
#      choose which of them to browse to?

# Change working directory up a variable number of levels.
cd..() {
    cd "$(.. "$1")"
}

# Change working directory and list.
cl() {
    cd "$1" || return $?
    
    printf "\e[96m$(pwd -P):\e[0m\n"
    ls
}

# Change working directory up a variable number of levels and list.
cl..() {
    cl "$(.. "$1")"
}

# Change working directory or output file contents.
c() {
    if [ $# -eq 0 -o -d "$1" ]; then
        cl "$1"
    elif [ -f "$1" ]; then
        cat "$1"
    else
        errcho "$0: c: $1: No such file or directory"
    fi
}

# Sensible(?) aliases for `c`.
alias c.='c .'
alias c..='cl..'
