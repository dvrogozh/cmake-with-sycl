#include <iostream>
#include <cuda_runtime.h>
#include "lib.h"

// CUDA kernel equivalent to SYCL parallel_for lambda
__global__ void set_ids_kernel(std::size_t *ids, std::size_t n) {
    std::size_t idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < n) {
        ids[idx] = idx;
    }
}

void extern_lib_uses_cuda() {
    const std::size_t N = 16;
    std::size_t *ids = nullptr;

    // Allocate Unified Memory accessible from CPU and GPU
    cudaMallocManaged(&ids, N * sizeof(std::size_t));

    // Configure and launch kernel
    const int threadsPerBlock = 32;
    const int blocksPerGrid = (N + threadsPerBlock - 1) / threadsPerBlock;
    set_ids_kernel<<<blocksPerGrid, threadsPerBlock>>>(ids, N);

    // Wait for GPU execution to complete before CPU access
    cudaDeviceSynchronize();

    for (std::size_t i = 0; i < N; ++i) {
        std::cout << "Hello from worker " << ids[i] << "\n";
    }

    // Free Unified Memory
    cudaFree(ids);
}
