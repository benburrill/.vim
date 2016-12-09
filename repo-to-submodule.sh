#!/bin/bash

# repo-to-submodule.sh <directory>[, ...]
# If possible, converts a repo inside the working repo into a submodule
# pointing to its remote origin.

if [[ "$#" = "0" ]]; then
    echo "Usage: repo-to-submodule.sh <directory>[, ...]"
    exit 1
fi

for dir; do
    # No matter what, add the directory.
    git add "$dir"

    # Not a directory, no big deal, print out the error and move on to
    # the next one.
    cd "$dir" || continue

    url="$(git config --get remote.origin.url)"

    cd - > /dev/null

    if [[ "$url" ]]; then
        git rm -rf --cached "$dir" > /dev/null
        git submodule add "$url" "$dir"
    fi
done
