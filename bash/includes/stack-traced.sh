function eval_stack {
        echo '>' stack "$@" 
        eval command stack "$@" 2>&1 | while IFS= read -r l; do
            echo "  > $l"
        done
        # Return exit code of command before pipe.
        return ${PIPESTATUS[0]}
}

function stack {
	case "$1" in
		build)
			# Track time of 'stack build'.
			local -r t0="$(date +%s)"
			eval_stack "$@" # $MO_STACK_OPTS
                        local -r x=$?
			local -r t1="$(date +%s)"
			# Record time if strictly more than 1s.
			local -r dt="$((t1-t0))"
			[ "$dt" -gt 1 ] &&
				echo "$(pwd)	$(date +"%Y-%m-%dT%T")	$dt" >> ~/stacktime.txt
                        return "$x"
			;;
		test)
			# Run 'stack build' first to ensure that only compilation
			# time is tracked.
			stack build $MO_STACK_OPTS --test --no-run-tests && eval_stack "$@" $MO_STACK_OPTS 
	    		;;
                *)
                        # For 'stack exec' etc.
                        # Note that 'stack run' also goes here because it doesn't support many flags
                        # ('--fast', '--flag', ...). Use 'stack build' followed by 'stack exec' instead.
			command stack "$@"
	    		;;
	esac
}

# Make available to subshells (like run.sh).
export -f eval_stack
export -f stack 
