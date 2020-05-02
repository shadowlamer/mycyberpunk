#!/bin/bash

cd $DIR
npm run make-tape
npm run build

mkdir -p $DIR/out
cp -r $DIR/docker/* $DIR/out
cp -r $DIR/dist $DIR/out/build
