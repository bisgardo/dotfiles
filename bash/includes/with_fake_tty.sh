function with_fake_tty {
	# Call command while pretending to be a tty.
	script -qfec "$(printf "%q " "$@")"
}
