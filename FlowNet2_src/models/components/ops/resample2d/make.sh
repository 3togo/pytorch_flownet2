#!/usr/bin/env bash
PYTHON=${PYTHON:-"python"}
TORCH=$($PYTHON -c "import os; import torch; print(os.path.dirname(torch.__file__))")

cd src
echo "Compiling resample2d kernels by nvcc..."
[ -f Resample2d_kernel.o ] && rm Resample2d_kernel.o
[ -d ../_ext ] && rm -r ../_ext

nvcc -c -o Resample2d_kernel.o Resample2d_kernel.cu -x cu -Xcompiler -fPIC -arch=sm_50 -I ${TORCH}/lib/include/TH -I ${TORCH}/lib/include/THC -I ${TORCH}/lib/include -std=c++11

cd ../
$PYTHON build.py
