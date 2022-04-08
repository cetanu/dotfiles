#!/bin/sh

filename="${HOME}/Documents/journal/$(date +%Y-%m-%d).md"

if [ ! -f $filename ]; then
    echo "# $(date +%Y-%m-%d)" > $filename
fi

nvim -c "norm Go" \
    -c "norm Go## $(date +%H:%M)" \
    -c "norm G2o" \
    -c "norm zz" \
    -c "startinsert" $filename
