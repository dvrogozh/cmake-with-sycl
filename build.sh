#!/bin/bash

rm -rf _build
mkdir _build
cmake -B _build -S . \
  -G Ninja \
  -DCMAKE_EXPERIMENTAL_SYCL=c0d1fb10-2ece-420e-9d29-7d7f2b300f25 \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_SYCL_COMPILER=icpx
cmake --build _build --target all --verbose
