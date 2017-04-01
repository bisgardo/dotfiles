# Ignore case in pathname extension
#shopt -s nocaseglob

# (http://askubuntu.com/questions/87061/can-i-make-tab-auto-completion-case-insensitive-in-the-terminal)
# If ~./inputrc doesn't exist yet, first include the original /etc/inputrc so we don't override it.
if [ ! -a ~/.inputrc ]; then echo '$include /etc/inputrc' > ~/.inputrc; fi

# Add option to ~/.inputrc to enable case-insensitive tab completion.
echo 'set completion-ignore-case On' >> ~/.inputrc
