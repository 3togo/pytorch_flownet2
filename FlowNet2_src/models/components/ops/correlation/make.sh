#!/usr/bin/env bash
PYTHON=${PYTHON:-"python"}
TORCH=$($PYTHON -c "import os; import torch; print(os.path.dirname(torch.__file__))")

cd src

echo "Compiling correlation kernels by nvcc..."
[ -f correlation_cuda_kernel.o ] && rm correlation_cuda_kernel.o
[ -d ../_ext ] && rm -r ../_ext

nvcc -c -o correlation_cuda_kernel.o correlation_cuda_kernel.cu -x cu -Xcompiler -fPIC -arch=sm_50

cd ../
$PYTHON build.py
