#include <iostream>
#include <sycl/sycl.hpp>
#include "lib.h"

void extern_lib_uses_sycl() {
  sycl::queue q;
  const std::size_t N = 16;

  std::size_t *ids = sycl::malloc_shared<std::size_t>(N, q);

  q.parallel_for<struct KN>(
    sycl::range<1>{N},
    [=](sycl::id<1> idx) {
      ids[idx] = idx[0];
    }
  ).wait();

  for (std::size_t i = 0; i < N; ++i) {
    std::cout << "Hello from worker " << ids[i] << "\n";
  }

  sycl::free(ids, q);
}
