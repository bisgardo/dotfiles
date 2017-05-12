# Base utilities that includes may rely upon.

################
# INPUT/OUTPUT #
################

# Echo to std err.
alias errcho='>&2 echo'

###################
# STRING MATCHING #
###################

# Test if $1 is a prefix of $2.
is_prefix() {
    local prefix="$1"
    local string="$2"
    
    # Special case: The empty string is a prefix of any string.
    if [ -z "$prefix" ]; then
        return 0
    fi
    
    # $string with the (literal) prefix $prefix removed.
    local suffix="${string#"$prefix"}"
    
    # If $prefix is a (non-empty) prefix, then
    # $suffix will be different from $string.
    [ "$suffix" != "$string" ]
}

# Test if $1 is a pattern that matches a prefix of $2.
matches_prefix() {
    local prefix="$1"
    local string="$2"
    
    # Special case: The empty string is a prefix of any string.
    if [ -z "$prefix" ]; then
        return 0
    fi
    
    # $string with the longest matching prefix of the pattern $prefix removed.
    local suffix="${string##$prefix}"
    
    # If $prefix is a (non-empty) prefix, then
    # $suffix will be different from $string.
    [ "$suffix" != "$string" ]
}

# Test if $1 is a suffix of $2.
is_suffix() {
    local suffix="$1"
    local string="$2"
    
    # Special case: The empty string is a suffix of any string.
    if [ -z "$suffix" ]; then
        return 0
    fi
    
    # $string with the (literal) suffix $suffix removed.
    local prefix="${string%"$suffix"}"
    
    # If $suffix is a (non-empty) suffix, then
    # $suffix will be different from $string.
    [ "$prefix" != "$string" ]
}

# Test if $1 is a pattern that matches a suffix of $2.
matches_suffix() {
    local suffix="$1"
    local string="$2"
    
    # Special case: The empty string is a suffix of any string.
    if [ -z "$suffix" ]; then
        return 0
    fi
    
    # $string with the longest matching part of the pattern $suffix removed.
    local prefix="${string%%$suffix}"
    
    # If $suffix is a (non-empty) suffix, then
    # $prefix will be different from $string.
    [ "$prefix" != "$string" ]
}
