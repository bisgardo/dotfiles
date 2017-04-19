if [ "$DOTFILES_OS" = OSX ]; then
    # TODO Replace with `CLICOLOR`/`LSCOLORS` as described in the man page?
    alias ls='ls -G'
elif [ -x /usr/bin/dircolors ]; then
    # From Ubuntu's `.bashrc`:
    # Enable color support of `ls` and also add handy aliases
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias l='ls -CF'
alias ll='ls -alF'
alias la='ls -A'

alias ls..='ls ..'
