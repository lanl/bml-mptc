#!/bin/bash

# Make sure all the paths are correct

rm -r build
rm -r install

MY_PATH=$(pwd)
echo $OLCF_OPENBLAS_ROOT

export CC=${CC:=gcc}
export FC=${FC:=gfortran}
export CXX=${CXX:=g++}
export BLAS_VENDOR=${BLAS_VENDOR:=Auto}
export BML_OPENMP=${BML_OPENMP:=yes}
export INSTALL_DIR=${INSTALL_DIR:="${MY_PATH}/install-magma"}
export BML_MAGMA=${BML_MAGMA:=yes}
export MAGMA_ROOT=${OLCF_MAGMA_ROOT}
export BML_TESTING=${BML_TESTING:=yes}
export CMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE:=Release}
#export CMAKE_Fortran_FLAGS=${CMAKE_Fortran_FLAGS:="-O2 -ffree-form -ffree-line-length-200 -L${OLCF_OPENBLAS_ROOT}/lib -lopenblas"}
#export CMAKE_C_FLAGS=${CMAKE_C_FLAGS:="-O2 -I${HIP_PATH}/include -L${OLCF_OPENBLAS_ROOT}/lib -lopenblas"}
export CMAKE_Fortran_FLAGS=${CMAKE_Fortran_FLAGS:="-O0 -g -ffree-form -ffree-line-length-200 -L${OLCF_OPENBLAS_ROOT}/lib -lopenblas"}
export CMAKE_C_FLAGS=${CMAKE_C_FLAGS:="-O0 -g -I${HIP_PATH}/include -L${OLCF_OPENBLAS_ROOT}/lib -lopenblas"}
export EXTRA_LINK_FLAGS=${EXTRA_LINK_FLAGS:="-L${OLCF_OPENBLAS_ROOT}/lib -lopenblas"}

./build.sh configure

pushd build
make -j8
make install
popd
