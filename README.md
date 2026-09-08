# Example project to play with CUDA support in Cmake

> [!CAUTION]
> CUDA examples were just built, but not tried at runtime.

## Build with Docker

Run the following to build with Docker and collect logs sharable with others (note
stripping of messy line endings):

```
./build-docker.sh --no-cache 2>&1 | col -b >example.log
```

Not that all script arguments are passed to docker build command. Usefull arguments:

| Argument | Default |
| --- | --- |
| `CMAKE_CUDA_SEPARABLE_COMPILATION` | `OFF` |
| `CMAKE_CUDA_RESOLVE_DEVICE_SYMBOLS` | `OFF` |

Run the following to try out built examples:

```
docker run -it --rm --privileged cuda-example /workspace/_build/main-static
docker run -it --rm --privileged cuda-example /workspace/_build/main-shared
```

## Build on baremetal

If you have Intel or Nvidia development environment, you can build on baremetal with the
following script:

```
./build.sh
```
