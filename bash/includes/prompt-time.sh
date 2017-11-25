PROMPT_TIME=
_prompt_time_set() {
    PROMPT_TIME="$(date +"%s")"
}

prompt-time() {
    local time="$(date +"%s")"
    local dur=$((time-PROMPT_TIME))
    
    local hours="0$(($dur / 3600))"
    local mins="0$((($dur / 60) % 60))"
    local secs="0$(($dur % 60))"
    
    echo "${hours:(-2)}:${mins:(-2)}:${secs:(-2)}"
}

export PROMPT_COMMAND="_prompt_time_set;$PROMPT_COMMAND"
