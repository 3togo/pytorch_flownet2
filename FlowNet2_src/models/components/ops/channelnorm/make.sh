 #!/usr/bin/env bash
PYTHON=${PYTHON:-"python"}
echo "PYTHON_PATH=$PYTHON"
TORCH=$($PYTHON -c "import os; import torch; print(os.path.dirname(torch.__file__))")
echo "TORCH_PATH=$TORCH"
cd src
echo "Compiling channelnorm kernels by nvcc..."
if [ -f ChannelNorm_kernel.o ]; then
    rm ChannelNorm_kernel.o
fi

if [ -d ../_ext ]; then
    rm -r ../_ext
fi
nvcc -c -o ChannelNorm_kernel.o ChannelNorm_kernel.cu -x cu -Xcompiler -fPIC -arch=sm_50 -I ${TORCH}/lib/include/TH -I ${TORCH}/lib/include/THC -I ${TORCH}/lib/include -std=c++11

cd ../
$PYTHON build.py
