FROM nvidia/cuda:13.3.1-devel-ubuntu26.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

COPY CMakeLists.txt lib.h lib.cu main.cpp build.sh ./

ARG CMAKE_CUDA_SEPARABLE_COMPILATION=OFF
ARG CMAKE_CUDA_RESOLVE_DEVICE_SYMBOLS=OFF
RUN cmake -B _build -S . \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_CUDA_SEPARABLE_COMPILATION=${CMAKE_CUDA_SEPARABLE_COMPILATION} \
      -DCMAKE_CUDA_RESOLVE_DEVICE_SYMBOLS=${CMAKE_CUDA_RESOLVE_DEVICE_SYMBOLS} \
    && cmake --build _build --target all --verbose -j1
