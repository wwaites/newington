#!/bin/sh

x=0
for input in $*; do
   x=$(($x+1))
   < ${input} sed -e 's/^X:.*/X: '${x}'/'
   echo
done
