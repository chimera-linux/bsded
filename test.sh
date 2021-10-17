#!/bin/sh

cd test

ED=../$1

./mkscripts.sh "$ED" || exit 1
OUT=$(./ckscripts.sh "$ED")
test -n $OUT
