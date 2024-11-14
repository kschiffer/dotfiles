#!/bin/bash

# Define the path to store the Brewfile
BREWFILE_PATH="$HOME/git/dotfiles/Brewfile"

# Run brew bundle dump to update the Brewfile with all current packages
brew bundle dump --file="$BREWFILE_PATH" --describe --force

echo "Brewfile updated at $BREWFILE_PATH on $(date)"
