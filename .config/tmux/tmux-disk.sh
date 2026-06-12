#!/bin/bash

home_dev=$(df --output=source "$HOME" 2>/dev/null | awk 'NR==2{print $1}')
root_dev=$(df --output=source /    2>/dev/null | awk 'NR==2{print $1}')
avail=$(df -h --output=avail "$HOME" 2>/dev/null | awk 'NR==2{print $1}')

if [ "$home_dev" = "$root_dev" ]; then
    printf '#[fg=red]💾 %s#[default]' "$avail"
else
    printf '💾 %s' "$avail"
fi
