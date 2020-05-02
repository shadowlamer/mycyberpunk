#!/bin/bash

PROJECT="cyberpunk"
TAPE="src/program.tap"
MAIN="src/bas/engine/main.bas"
INCLUDE="src/bas"

m4 -I ${INCLUDE} ${MAIN}|grep -e "\S" > program.bas
zmakebas -i 1 -a 10 -l -o ${TAPE} -n ${PROJECT} program.bas
jsbin2tap -p -o ${TAPE} assets/*.scr
