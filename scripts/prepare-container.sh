#!/bin/bash

set -e -u -x

SUDO=$(which sudo || true)

for i in $(seq 5); do
    ${SUDO} apt-get update && break
done

${SUDO} apt-get install --assume-yes --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    gnupg \
    wget

cat <<EOF | ${SUDO} tee /etc/apt/sources.list.d/clang.list
# i386 not available
deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic main
# deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic main
# 11
deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-11 main
# deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-11 main
# 12
deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-12 main
# deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-12 main
deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-13 main
# deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-13 main
EOF
${SUDO} bash -c "cat > /etc/apt/trusted.gpg.d/llvm.gpg" < <(wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | gpg --dearmor)

cat <<EOF | ${SUDO} tee /etc/apt/sources.list.d/cmake.list
deb http://ppa.launchpad.net/janisozaur/cmake-update-bionic/ubuntu bionic main
# deb-src http://ppa.launchpad.net/janisozaur/cmake-update-bionic/ubuntu bionic main
EOF
gpg --keyserver keyserver.ubuntu.com \
    --recv-keys DBA92F17B25AD78F9F2D9F713DEC686D130FF5E4
${SUDO} bash -c "cat > /etc/apt/trusted.gpg.d/cmake.gpg" < <(gpg --export DBA92F17B25AD78F9F2D9F713DEC686D130FF5E4)

cat <<EOF | ${SUDO} tee /etc/apt/sources.list.d/toolchain.list
deb http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu bionic main
# deb-src http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu bionic main
EOF
gpg --keyserver keyserver.ubuntu.com \
    --recv-keys 60C317803A41BA51845E371A1E9377A2BA9EF27F
${SUDO} bash -c "cat > /etc/apt/trusted.gpg.d/toolchain.gpg" < <(gpg --export 60C317803A41BA51845E371A1E9377A2BA9EF27F)

cat <<EOF | ${SUDO} tee /etc/apt/sources.list.d/emacs.list
deb http://ppa.launchpad.net/kelleyk/emacs/ubuntu bionic main
# deb-src http://ppa.launchpad.net/kelleyk/emacs/ubuntu bionic main
EOF
gpg --keyserver keyserver.ubuntu.com \
    --recv-keys 873503A090750CDAEB0754D93FF0E01EEAAFC9CD
${SUDO} bash -c "cat > /etc/apt/trusted.gpg.d/emacs.gpg" < <(gpg --export 873503A090750CDAEB0754D93FF0E01EEAAFC9CD)

apt-key list

for i in $(seq 5); do
    ${SUDO} apt-get update && break
done

${SUDO} ln -fs /usr/share/zoneinfo/UTC /etc/localtime
${SUDO} apt-get install --assume-yes tzdata
DEBIAN_FRONTEND=noninteractive ${SUDO} dpkg-reconfigure \
    --frontend noninteractive tzdata

${SUDO} apt-get install --assume-yes --no-install-recommends \
    apt-utils \
    build-essential \
    gfortran \
    bundler \
    cmake cmake-data \
    emacs27 \
    clang-12 llvm-12-dev libomp-12-dev \
    gcc-4.8 g++-4.8 gfortran-4.8 \
    gcc-9 g++-9 gfortran-9 \
    gcc-10 g++-10 gfortran-10 \
    gcc-11 g++-11 gfortran-11 \
    git-core \
    indent \
    less \
    libblas-dev liblapack-dev \
    libscalapack-openmpi-dev \
    mpi-default-dev \
    openmpi-bin \
    openssh-client \
    python python-pip python-wheel python-pkg-resources \
    sudo \
    texlive \
    valgrind \
    vim

${SUDO} pip install --system bashate
