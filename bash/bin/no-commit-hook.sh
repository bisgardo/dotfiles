#!/usr/bin/env bash
#
# Hook for rejecting commit with changes that include the marker '@nocommit'.
# This script and the pre-commit tool installed (https://pre-commit.com/)
# need to be installed on PATH.
#
# Add to project by creating .pre-commit-config.yaml with contents:
#
#     repos:
#       - repo: local
#         hooks:
#         -   id: no-commit
#             exclude: .pre-commit-config.yaml
#             name: check for code that should not be committed
#             entry: no-commit-hook.sh
#             language: system
#
# and then run 'pre-commit install'.

readarray -t files <<< $(git diff --no-ext-diff --cached --name-only -i -G '@nocommit')

# Check if files was empty. Note that because of the way git diff works, if no files were found, the array will have a single empty element, so just checking the count won't work.
if [ -n "${files[@]}" ]; then
  echo "ERROR: The following files have staged changes that include a '@nocommit' marker."
  for f in "${files[@]}"; do
    echo "- $f"
  done
  echo
  echo "Ignore this error by running the commit command with '--no-verify'."
  exit 1
fi
