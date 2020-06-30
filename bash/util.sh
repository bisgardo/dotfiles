# Base utilities that includes may rely upon.

# TODO Add all functions for standard "tricks", substitution etc.
#      - names/exemplifies common constructs
#      - gives solutions to pretty solutions
#      - defines an interface that can be implemented seperately
#        for different shells (separate project?).

################
# INPUT/OUTPUT #
################

# Echo to std err.
alias errcho='>&2 echo'

# Play a "beep".
alias beep='echo -ne "\a"'

# Function for setting status code.
status() {
	return $1
}

###################
# STRING MATCHING #
###################

# Test if $1 is a prefix of $2.
is_prefix() {
	local -r prefix="$1"
	local -r string="$2"
	
	# Special case: The empty string is a prefix of any string.
	if [ -z "$prefix" ]; then
		return
	fi
	
	# $string with the (literal) prefix $prefix removed.
	local -r suffix="${string#"$prefix"}"
	
	# If $prefix is a (non-empty) prefix, then
	# $suffix will be different from $string.
	[ "$suffix" != "$string" ]
}

# Test if $1 is a pattern that matches a prefix of $2.
matches_prefix() {
	local -r prefix="$1"
	local -r string="$2"
	
	# Special case: The empty string is a prefix of any string.
	if [ -z "$prefix" ]; then
		return
	fi
	
	# $string with the longest matching prefix of the pattern $prefix removed.
	local -r suffix="${string##$prefix}"
	
	# If $prefix is a (non-empty) prefix, then
	# $suffix will be different from $string.
	[ "$suffix" != "$string" ]
}

# Test if $1 is a suffix of $2.
is_suffix() {
	local -r suffix="$1"
	local -r string="$2"
	
	# Special case: The empty string is a suffix of any string.
	if [ -z "$suffix" ]; then
		return
	fi
	
	# $string with the (literal) suffix $suffix removed.
	local -r prefix="${string%"$suffix"}"
	
	# If $suffix is a (non-empty) suffix, then
	# $suffix will be different from $string.
	[ "$prefix" != "$string" ]
}

# Test if $1 is a pattern that matches a suffix of $2.
matches_suffix() {
	local -r suffix="$1"
	local -r string="$2"
	
	# Special case: The empty string is a suffix of any string.
	if [ -z "$suffix" ]; then
		return 0
	fi
	
	# $string with the longest matching part of the pattern $suffix removed.
	local -r prefix="${string%%$suffix}"
	
	# If $suffix is a (non-empty) suffix, then
	# $prefix will be different from $string.
	[ "$prefix" != "$string" ]
}

#########################
# STRING TRANSFORMATION #
#########################

split() {
	local -r delimiter="$1"
	local part
	while read -d "$delimiter" part; do echo "$part"; done
	echo "$part"
}

join() {
	local -r delimiter="$1"
	local part
	while read part; do
		echo -n "$part$delimiter"
	done
	echo "$part"
}
