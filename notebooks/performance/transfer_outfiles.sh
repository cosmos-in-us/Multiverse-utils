#!/bin/bash

TARGET_SERVER="gilee@exgalcos.snu.ac.kr"
TARGET_PATH="where/you/want/to/download"
PASSWORD="your/password"

find . -type f -name "outfile*" -path "./run-*" | while read -r target_file; do

    # parent direcory
    PARENT_DIRECTORY=$(basename "$(dirname "$target_file")")

    # extract PID
    FILE_PID=$(basename "$target_file" | grep -o "o[0-9]*" | tail -n 1)

    # file name
    FILE_NAME="${PARENT_DIRECTORY}-${FILE_PID}.txt"

    # send the file
    sshpass -p "$PASSWORD" scp "$target_file" "$TARGET_SERVER:$TARGET_PATH/$FILE_NAME"

    # print the status
    if [[ $? -eq 0 ]]; then
        echo "Successfully transferred: $target_file as $FILE_NAME"
    else
        echo "Failed to transfer: $target_file"
    fi
done