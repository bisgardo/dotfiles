# Change directory to working directory with symlinks resolved.
cwd() {
    command cd "$(pwd -P)"
}
