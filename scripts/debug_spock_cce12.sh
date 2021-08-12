#!/bin/bash
TMPDIR=$(mktemp -p . -d)
pushd ${TMPDIR}
git clone https://github.com/lanl/bml.git
cd bml
git checkout spock_magma
source scripts/setenv_spock_offload.sh
bash scripts/build_spock_offload_cce.sh |& tee build_cce12.log
module swap cce cce/11.0.4
bash scripts/build_spock_offload_cce.sh |& tee build_cce11.log
