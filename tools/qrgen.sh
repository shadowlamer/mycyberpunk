#!/bin/bash
if echo $1 | grep -qs github; then
URL=$(curl -s -i https://git.io -F "url=$1" | grep "Location:"| cut -d\  -f2)
else
URL="$1"
fi
qrencode -s 1 -o - -l L -t ASCII "$URL" |\
sed 's/##/0/g'| sed 's/\ \ /1/g' |\
sed s/1$//g |\
tail -n 32 |\
tr -d "\n" |\
while read -N 8 byte; do
  printf '%d,' "$((2#$byte))"
done | sed s/,$//g
echo
