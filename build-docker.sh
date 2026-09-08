#!/bin/bash

set -x

docker build -f Dockerfile -t cuda-example --progress=plain "$@" .
