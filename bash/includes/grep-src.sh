# Source grep: grep recursively, ignore binary files, include line numbers, and include 2 lines around matches.
alias grep-src="grep -rIn -C2"

# Haskell grep: source grep searching only haskell source files.
alias grep-hs="grep-src --include '*.hs'"
