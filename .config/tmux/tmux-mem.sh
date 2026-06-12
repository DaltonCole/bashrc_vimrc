#!/bin/bash
free | awk 'NR==2{printf "MEM %d%% %.1fG/%.1fG", $3/$2*100, $3/1024/1024, $2/1024/1024}'
