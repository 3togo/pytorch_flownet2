 #!/usr/bin/env bash
PYTHON=${PYTHON:-"python"}
echo "PYTHON_PATH=$PYTHON"
TORCH=$($PYTHON -c "import os; import torch; print(os.path.dirname(torch.__file__))")
echo "TORCH_PATH=$TORCH"
cd src
echo "Compiling channelnorm kernels by nvcc..."
[ -f ChannelNorm_kernel.o ] && rm ChannelNorm_kernel.o
[ -d ../_ext ] && rm -r ../_ext

nvcc -c -o ChannelNorm_kernel.o ChannelNorm_kernel.cu -x cu -Xcompiler -fPIC -arch=sm_50 -I ${TORCH}/lib/include/TH -I ${TORCH}/lib/include/THC -I ${TORCH}/lib/include -std=c++11

cd ../
$PYTHON build.py
