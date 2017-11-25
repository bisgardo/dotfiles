# Mac (with brew): Setup Git autocompletion.
if [ -x "$(command -v brew)" ]; then
    if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
        source "$(brew --prefix)/etc/bash_completion"
    fi
fi

# https://stackoverflow.com/a/12142066
git-current-branch() {
    git rev-parse --abbrev-ref HEAD
}

# Function for moving accidental commit to new branch and roll back the old branch. 
git-commit-to-branch() {
    local -r new_branch="$1"
    
    # TODO Validate that new_branch is valid, different from the old one etc.
    
    local -r current_branch="$(git-current-branch)"
    
    echo "Moving last commit on branch '$current_branch' to new branch '$new_branch'"
    
    git checkout -b "$new_branch" &&
    git checkout "$current_branch" &&
    git reset --hard HEAD~1 &&
    git checkout "$new_branch"
}
