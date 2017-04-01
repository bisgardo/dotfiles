# Utility aliases and functions.

# Command shortcut aliases.
# - use colors in `ls`.
alias ls='ls -G'
alias l='ls -l'
alias ll='l'
alias la='ls -a'
alias lla='ls -la'
alias e='emacs'
alias m='make'
alias g='git'
alias a='arc'

alias ls..='ls ..'

# Redefinition aliases
# - resolve symbolic links in `pwd`.
alias pwd='pwd -P'

# Functions.

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
    if [ -f "$1" ]; then
	cat "$1"
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

# From 'http://stackoverflow.com/a/22219586/883073'.
withhead() {
    read -r head
    printf "%s\n" "$head"
    exec "$@"
}

alias wh=withhead

alias beep='echo -ne "\a"'
