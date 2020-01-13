# Replace `cat` and `cd` with enhanced versions. Let `cd .` be interpreted as
# "change directory to dir of last file that was `cat`'ed"
alias __cat="$(which cat)"
cat() {
	__cat "$@"
	__CAT_DIR="$(dirname "$1")"
}

ct() {
	if [ -n "$__CAT_DIR" ]; then
		cd "$__CAT_DIR"
	fi
}

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
#      autocomplete.

# TODO Can make command for listing subdirectories matching a pattern and then
#      choose which of them to browse to?

# Change working directory up a variable number of levels.
cd..() {
	cd "$(.. "$1")"
}

# Change working directory and list.
cl() {
	if [ $# -eq 0 ]; then
		cd
	else
		# Expand spaces in multiple arguments.
		IFS=' ' cd "$*" || return $?
	fi
	
	local -r wd="$(pwd -P)"
	if [ "$wd" != "$HOME" ]; then
		# TODO On print new dir once on `cd -` (i.e. redirect `cd ` to null?).
		printf "\e[96m$wd:\e[0m\n"
		ls
	fi
}

# Change working directory up a variable number of levels and list.
cl..() {
	cl "$(.. "$1")"
}

# Change working directory or output file contents.
# TODO Do the same for l; ls vs less.
c() {
	if [ -f "$1" ]; then
			cat "$1"
	else
		cl $@
		#errcho "$0: c: $1: No such file or directory"
	fi
}

# Sensible(?) aliases for `c`.
alias c.='c .'
alias c..='cl..'
