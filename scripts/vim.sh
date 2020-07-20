#! /bin/bash

# Set PEP8 max line length to 120 characters
config_dir=~/.config/
mkdir -p "$config_dir"
echo "[flake8]
max-line-length = 120" > ${config_dir}flake8
