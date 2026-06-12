#!/bin/bash
mpstat 1 1 | awk '/Average/{printf "CPU %.0f%%", 100-$NF}'
