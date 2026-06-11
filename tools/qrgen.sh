#!/bin/bash
URL="$1"
qrencode -s 1 -o - -l L -t ASCII "$URL" |\
sed 's/##/0/g'| sed 's/\ \ /1/g' |\
awk '{a[NR]=$0} END{
  skip_v=int((NR-32)/2); if(skip_v<0) skip_v=0
  for(i=skip_v+1; i<=skip_v+32 && i<=NR; i++){
    line=a[i]; len=length(line)
    if(len>32){skip_h=int((len-32)/2); line=substr(line,skip_h+1,32)}
    if(len<32){for(j=len;j<32;j++) line=line "1"}
    print line
  }
}' |\
tr -d "\n" |\
while read -N 8 byte; do
  printf '%d,' "$((2#$byte))"
done | sed s/,$//g
echo
