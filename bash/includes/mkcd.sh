# Make directory and make it the working directory.
mkcd() {
    mkdir -p "$1" && cl "$1"
}
