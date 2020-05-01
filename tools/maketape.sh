#!/bin/bash

PROJECT="cyberpunk"
TAPE="src/program.tap"

m4 -I src/bas src/bas/main.bas|grep -e "\S" > program.bas
zmakebas -i 1 -a 10 -l -o ${TAPE} -n ${PROJECT} program.bas

for SCR in assets/*.scr; do
  NAME=$(basename $SCR ".scr")
  jsbin2tap -o $NAME -a 16384 $SCR
  cat $NAME >> ${TAPE}
  rm ${NAME}
done
