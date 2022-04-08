#!/bin/sh

journals="${HOME}/Documents/journal"
filename="${journals}/$(date +%Y-%m-%d).md"

if [ ! -f $filename ]; then
    echo "# $(date +%Y-%m-%d)" > $filename
fi

nvim -c "norm Go" \
    -c "norm Go## $(date +%H:%M)" \
    -c "norm G2o" \
    -c "norm zz" \
    -c "startinsert" $filename

cd ${journals}
git add -A
git commit -am "$(date +%s)"
git push
