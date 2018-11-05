# Rename file or directory relative to its current directory.
rename() {
	mv -i "$1" "$(dirname "$1")/$2"
}

alias rn='rename'
