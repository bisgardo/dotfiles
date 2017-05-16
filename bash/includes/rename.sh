# Rename file or directory relative to its current directory.
rename() {
    mv "$1" "$(dirname "$1")/$2"
}
