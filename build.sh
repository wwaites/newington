#!/bin/sh

rm -f newington.abc

if test $# -eq 0; then
    set *.abc
fi

for abc in $*; do
    name=`echo $abc | sed -e 's/\.abc$//'`
    title=`grep '^T:' ${abc} | sed -e 's/^T: *//'`
cat > ${name}.html <<EOF
---
layout: tune
title: ${title}
tune: ${name}
---
EOF
    git add ${name}.html
    abcm2ps -l -O ${name}.ps ${abc}
    ps2pdf ${name}.ps
    rm -f ${name}.ps
    git add ${name}.pdf
    pdftoppm -jpeg -cropbox ${name}.pdf ${name}
    for img in ${name}*.jpg; do
        git add ${img}
        echo "<img src=\"${img}\" />" >> ${name}.html
    done
done

sh abccat.sh *.abc > newington.abc
abcm2ps -l -O newington.ps newington.abc
ps2pdf newington.ps
rm -f newington.ps

