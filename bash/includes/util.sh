# Utility aliases and functions.

# Command shortcut aliases.
# - use colors in `ls`.
alias e='emacs'
alias m='make'
alias g='git'
alias a='arc'

# Prints path of ancestor folder n levels up.
..() {
    for i in $(seq 1 $1); do
        printf '../'
    done
}

# Make directory and make it the working directory.
mkcd() {
    mkdir -p "$1" && cl "$1"
}

cd..() {
    cd "$(.. "$1")"
}

cl() {
    cd $1 # No quotes.
    printf "\e[96m$(pwd -P):\e[0m\n"
    ls
}

cl..() {
    cl "$(.. "$1")"
}

c() {
    # TODO Implement save/goto dir by overriding `cat` and `cd` themselves?
    if [ -f "$1" ]; then
        # Cat if file.
        cat "$1"
        # Save the file's dir in var for easy jumping using `c .`.
        __DOT_C_DIR="$(dirname "$1")"
    elif [ "$1" = '.' -a -n "$__DOT_C_DIR" ]; then
        # Handle `c .`.
        cl "$__DOT_C_DIR"
        __DOT_C_DIR=
    else
        cl "$1"
    fi
}

c..() {
    c "$(.. "$1")"
}

cwd() {
    cd "$(pwd -P)"
}

rename() {
    local d="$(dirname "$1")"
    mv "$1" "$d/$2"
}

alias beep='echo -ne "\a"'
