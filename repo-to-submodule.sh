#!/bin/bash

# repo-to-submodule.sh <directory>[, ...]
# If possible, converts a repo inside the working repo into a submodule
# pointing to its remote origin.

if [[ "$#" = "0" ]]; then
    echo "Usage: repo-to-submodule.sh <directory>[, ...]"
    exit 1
fi

for dir; do
    cd "$dir" || exit 1

    url="$(git config --get remote.origin.url)"

    cd - > /dev/null

    if [[ "$url" ]]; then
        git rm --cached "$dir" >& /dev/null
        git submodule add "$url" "$dir"
    else
        # if we can't make it a submodule, just make sure it is added
        git add "$dir"
    fi
done
