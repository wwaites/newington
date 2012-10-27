#!/bin/sh

for abc in *.abc; do
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
    
