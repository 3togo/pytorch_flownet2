#!/usr/bin/env bash
PYTHON=${PYTHON:-"python"}
TORCH=$($PYTHON -c "import os; import torch; print(os.path.dirname(torch.__file__))")

cd src
echo "Compiling resample2d kernels by nvcc..."
if [ -f Resample2d_kernel.o ]; then
    rm Resample2d_kernel.o
fi
if [ -d ../_ext ]; then
    rm -r ../_ext
fi
nvcc -c -o Resample2d_kernel.o Resample2d_kernel.cu -x cu -Xcompiler -fPIC -arch=sm_30 -I ${TORCH}/lib/include/TH -I ${TORCH}/lib/include/THC -I ${TORCH}/lib/include -std=c++11

cd ../
$PYTHON build.py
