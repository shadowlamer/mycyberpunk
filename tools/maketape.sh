#!/bin/bash

PROJECT="cyberpunk"
TAPE="src/program.tap"

zmakebas -i 1 -a 10 -l -o ${TAPE} -n ${PROJECT} src/program.bas

for SCR in assets/*.scr; do
  NAME=$(basename $SCR ".scr")
  bin2tap -o $NAME -a 16384 $SCR
  cat $NAME >> ${TAPE}
  rm ${NAME}
done
