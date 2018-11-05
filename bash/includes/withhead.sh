# From 'http://stackoverflow.com/a/22219586/883073'.
withhead() {
	local head
	read -r head
	printf "%s\n" "$head"
	exec "$@"
}

alias wh=withhead
