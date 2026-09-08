cmake_minimum_required(VERSION 4.2)

project(cuda-linker-virality LANGUAGES CXX CUDA)

message("CMAKE_CUDA_SEPARABLE_COMPILATION=${CMAKE_CUDA_SEPARABLE_COMPILATION}")
message("CMAKE_CUDA_RESOLVE_DEVICE_SYMBOLS=${CMAKE_CUDA_RESOLVE_DEVICE_SYMBOLS}")

# Regular C++ sources
add_executable(main-static)
target_sources(main-static PRIVATE main.cpp)
target_link_libraries(main-static PRIVATE lib-static)

add_executable(main-shared)
target_sources(main-shared PRIVATE main.cpp)
target_link_libraries(main-shared PRIVATE lib-shared)

# SYCL sources
add_library(lib-static STATIC)
target_sources(lib-static PRIVATE lib.cu)

add_library(lib-shared SHARED)
target_sources(lib-shared PRIVATE lib.cu)
