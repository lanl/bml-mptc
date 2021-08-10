#!/bin/bash
git clone https://github.com/lanl/bml.git
git checkout spock_magma
cd bml
source scripts/setenv_spock_magma.sh
bash scripts/build_spock_magma_gcc.sh
pushd build
srun -A csc304 -t 00:30:00 -p ecp -N 1 -n 1 --ntasks-per-node=1 ./tests/C-tests/bml-test -n inverse -t dense -p single_real
popd
