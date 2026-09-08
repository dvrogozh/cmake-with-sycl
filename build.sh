#!/bin/bash

rm -rf _build
mkdir _build
cmake -B _build -S . \
  -DCMAKE_BUILD_TYPE=Release
cmake --build _build --target all --verbose -j1
