# Rename file or directory relative to its current directory.
rename() {
	if [ "$#" -ne 2 ]; then
		>&2 echo 'Usage: rename PATH NEW_NAME'
		return 1
	fi
	local path="$1"
	local new_name="$2"
	if [ -d "$path" ]; then
		path="$(cd "$path" && pwd -P)" # resolve '.', '..', etc.
	fi
	mv -i "$path" "$(dirname "$path")/$new_name"
	cd . # updates PWD if path of the dir itself changed
}
