#!/bin/bash
# Usage: command | add-timestamp-logs > logfile

while IFS= read -r line; do
    printf '%s %s\n' "$(date)" "$line";
done
