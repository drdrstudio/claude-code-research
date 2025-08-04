#!/bin/bash

# Check if exactly one argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <input_markdown_file>" >&2
    exit 1
fi

# Check if the input file exists
if [ ! -f "$1" ]; then
    echo "Error: File '$1' not found" >&2
    exit 1
fi

# Process the file
awk '
    /^## / {
        if (NR > 1) print "---"
    }
    {print}
' "$1"