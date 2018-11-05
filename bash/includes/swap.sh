swap() {
	local left="$1"
	local right="$2"
	
	# Find temporary file name.
	local tmp="$left--$right"
	while [ -a "$tmp" ]; do
		tmp="$tmp~"
	done
	
	mv "$left" "$tmp"
	mv "$right" "$left"
	mv "$tmp" "$right"
}
