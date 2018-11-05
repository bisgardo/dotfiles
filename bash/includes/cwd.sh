# Change directory to working directory with symlinks resolved.
cwd() {
	cd "$(pwd -P)"
}
