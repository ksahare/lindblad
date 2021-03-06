#!/bin/sh

# Download PETSc if necessary
if [ ! -e petsc-lite-3.5.3.tar.gz ];
then
  wget http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-lite-3.5.3.tar.gz
fi

if [ ! -e petsc-3.5.3 ];
then
# Extract PETSc
  tar xfz petsc-lite-3.5.3.tar.gz
else
# Clean out exisiting configuration directories
  rm -rf petsc-3.5.3/cpucmplx*
fi

cd petsc-3.5.3
PETSC_ARCH=cpucmplx-rel PETSC_DIR=`pwd` ./configure \
  --with-debugging=0 \
  --CFLAGS='-O3 -ffast-math -march=native' \
  --with-scalar-type=complex \
  --with-mpi=0 \
  --with-shared-libraries=0 \
  --prefix=../petsc-cpucmplx-rel \
  --with-x=0 \
  --with-ssl=0 \
  --with-fortran-kernels=1 \
  --with-pthread=0 \
  --with-mpiuni-fortran-binding=0 \
  --with-fortran-interfaces=0
make PETSC_DIR=`pwd` PETSC_ARCH=cpucmplx-rel all
make PETSC_DIR=`pwd` PETSC_ARCH=cpucmplx-rel install
cd -

