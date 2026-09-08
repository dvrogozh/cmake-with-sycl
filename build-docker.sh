#!/bin/bash

set -x

docker build -f Dockerfile -t sycl-example --progress=plain "$@" .
