#!/bin/bash

# Debug
if [ -n "$DEBUG_TRASH" ]; then
    function dbprint {
        echo $@
    }
else
    function dbprint {
        echo -n
    }
fi

if [ -z "$TRASH_DIR" -o ! -d "$TRASH_DIR" ]; then
    TRASH_DIR="$HOME/.Trash"
fi
dbprint "using TRASH_DIR=$TRASH_DIR"


# Pull out the options (files that start with -)
files=()
args=()

for something in $@; do
    if [ ${something:0:1} = '-' ]; then
        args+=("$something")
    else
        files+=("$something")
    fi
done

dbprint "Args: ${args[@]}"
dbprint "Files: ${files[@]}"

for file in "${files[@]}"; do
    # Look for an unused filename to move to
    baseFilename="$(basename "$file")"
    dbprint "base filename: $baseFilename"
    if [ -e "$TRASH_DIR/$baseFilename" ]; then
        counter=1
        while [ -e "$TRASH_DIR/copy$counter-$baseFilename" ]; do
            counter=$((counter+1))
        done
        filename="$TRASH_DIR/copy$counter-$baseFilename"
    else
        filename="$TRASH_DIR/$baseFilename"
    fi
    
    dbprint "mv $args $file $filename"
    mv $args "$file" "$filename"
done
