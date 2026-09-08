FROM intel/omix:0.4.0-devel-ubuntu24.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

# Temporary till https://gitlab.kitware.com/cmake/cmake/-/merge_requests/12467
# will get merged. Note redirections to /dev/null to silence logs.
RUN git clone -b sycl-language --depth 1 https://gitlab.kitware.com/vito.gamberini/cmake.git \
  && cd cmake && cmake -B _build -S . \
    -DCMAKE_INSTALL_PREFIX=/workspace/_install >/dev/null \
  && cmake --build _build -j >/dev/null \
  && cmake --install _build >/dev/null

ENV PATH=/workspace/_install/bin:$PATH

RUN which cmake && cmake --version

COPY CMakeLists.txt lib.h lib.cpp main.cpp build.sh ./

RUN source /opt/intel/oneapi/setvars.sh && cmake -B _build -S . \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_EXPERIMENTAL_SYCL=c0d1fb10-2ece-420e-9d29-7d7f2b300f25 \
      -DCMAKE_SYCL_COMPILER=icpx \
    && cmake --build _build --target all --verbose -j1
