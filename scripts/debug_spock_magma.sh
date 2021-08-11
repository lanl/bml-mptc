#!/bin/bash
TMPDIR=$(mktemp -p . -d)
pushd ${TMPDIR}
git clone https://github.com/lanl/bml.git
cd bml
git checkout spock_magma
source scripts/setenv_spock_magma.sh
bash scripts/build_spock_magma_gcc.sh
pushd build
srun -A csc304 -t 00:30:00 -p ecp -N 1 -n 1 --ntasks-per-node=1 ./tests/C-tests/bml-test -n inverse -t dense -p double_real
popd
