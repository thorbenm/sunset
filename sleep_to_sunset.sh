#!/bin/bash

while getopts ":o:t:" opt; do
  case $opt in
    o) offset="$OPTARG" ;;
    t) timeout="$OPTARG" ;;
    \?) echo "Invalid option: -$OPTARG" ;;
  esac
done

sunset=$(~/Programming/sunset/print_stockholm_sunset_sunrise.sh | tail -1 | awk '{print $NF}')
unix_now=$(date -d "now" "+%s")
unix_sunset=$(date -d "$sunset" "+%s")
unix_timeout=$(date -d "$timeout" "+%s")
seconds=$((unix_sunset - unix_now))
seconds=$((seconds + offset * 60))
seconds_timeout=$((unix_timeout - unix_now))
if [ $seconds -gt $seconds_timeout ]; then
    exit 2
fi
sleep $seconds
