CUDA_HOME=/usr/local/cuda-9.2
cc_=$CUDA_HOME/bin/gcc
cxx__=$CUDA_HOME/bin/g++
cc=/usr/bin/gcc-6
cxx=/usr/bin/g++-6

if [ ! -f $cc ]; then 
	sudo apt install gcc-6
fi
if [ ! -f $cxx ]; then 
    sudo apt install g++-6
fi	
if [ ! -f $cc_ ]; then 
    sudo ln -s $cc $cc_
fi
if [ ! -f $cxx_ ]; then 
    sudo ln -s $cxx $cc
fi


