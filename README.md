# Example project to play with SYCL support in Cmake

## CMake

See:
* https://gitlab.kitware.com/cmake/cmake/-/merge_requests/12467
* https://gitlab.kitware.com/vito.gamberini/sycl-examples

To activate Experimental SYCL mode, pass `CMAKE_EXPERIMENTAL_SYCL` to CMake
configuration cmdline:

```
cmake \
  -DCMAKE_EXPERIMENTAL_SYCL=c0d1fb10-2ece-420e-9d29-7d7f2b300f25
  ...
```

## Build with Docker

Run the following to build with Docker and collect logs sharable with others (note
stripping of messy line endings):

```
./build-docker.sh --no-cache 2>&1 | col -b >example.log
```

Not that all script arguments are passed to docker build command.

Run the following to try out built examples:

```
docker run -it --rm --privileged sycl-example /workspace/_build/main-static
docker run -it --rm --privileged sycl-example /workspace/_build/main-shared
```

## Build on baremetal

If you have Intel or Nvidia development environment, you can build on baremetal with the
following script:

```
./build.sh
```

## Compare with CUDA

See https://github.com/dvrogozh/cmake-with-sycl/tree/cuda branch in this repository.
