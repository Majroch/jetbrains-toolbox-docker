#!/bin/sh

/usr/local/bin/jetbrains-toolbox

while true; do
    currentProcesses="$(ps -aux | grep -i jetbrains-toolbox)"

    if [ "${currentProcesses}" = "" ]; then
        exit 0
    fi

    sleep 2
done

