cmake_minimum_required(VERSION 4.4)

project(sycl-linker-virality LANGUAGES CXX SYCL)

# Regular C++ sources
add_executable(main-static)
target_sources(main-static PRIVATE FILE_SET SOURCES FILES main.cpp)
target_link_libraries(main-static PRIVATE lib-static)

add_executable(main-shared)
target_sources(main-shared PRIVATE FILE_SET SOURCES FILES main.cpp)
target_link_libraries(main-shared PRIVATE lib-shared)

# SYCL sources
add_library(lib-static STATIC)
target_sources(lib-static PRIVATE FILE_SET SYCL FILES lib.cpp)
#target_compile_options(lib-static PRIVATE -fsycl-targets=spir64_gen)

add_library(lib-shared SHARED)
target_sources(lib-shared PRIVATE FILE_SET SYCL FILES lib.cpp)
target_compile_options(lib-static PRIVATE -fsycl-targets=spir64_gen)
target_link_options(lib-shared PRIVATE -fsycl-targets=spir64_gen -Xs "-device pvc -options -cl-poison-unsupported-fp64-kernels")

#target_link_options(lib-static PRIVATE -fsycl-targets=spir64_gen -Xs "-device pvc -options -cl-poison-unsupported-fp64-kernels")
