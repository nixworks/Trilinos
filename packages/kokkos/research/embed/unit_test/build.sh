#!/bin/bash

#-----------------------------------------------------------------------------
# Simple build script with options
#-----------------------------------------------------------------------------

KOKKOS="../../core"

source ${KOKKOS}/src/build_common.sh

# Process command line options and set compilation variables
#
# INC_PATH     : required include paths
# CXX          : C++ compiler with compiler-specific options
# CXX_SOURCES  : C++ files for host
# NVCC         : Cuda compiler with compiler-specific options
# NVCC_SOURCES : Cuda sources

#-----------------------------------------------------------------------------

INC_PATH="${INC_PATH} -I. -I../src"

#-----------------------------------------------------------------------------

if [ -n "${NVCC}" ] ;
then

  NVCC_SOURCES="${NVCC_SOURCES} TestArrayExp.cpp"

  echo ${NVCC} ${INC_PATH} -DTEST_KOKKOS_SPACE=Kokkos::CudaSpace TestArrayExp.cpp

  ${NVCC} ${INC_PATH} -DTEST_KOKKOS_SPACE=Kokkos::CudaSpace ${NVCC_SOURCES}

else

  echo ${CXX} ${INC_PATH} -DTEST_KOKKOS_SPACE=Kokkos::CudaSpace TestArrayExp.cpp

  ${CXX} ${INC_PATH} -DTEST_KOKKOS_SPACE=Kokkos::CudaSpace \
    -o TestArrayExp.cuda.o -c TestArrayExp.cpp

fi

#-----------------------------------------------------------------------------

echo ${CXX} ${INC_PATH} -c ${CXX_SOURCES}
echo ${CXX} ${INC_PATH} -c -DTEST_KOKKOS_SPACE=Kokkos::HostSpace TestArrayExp.cpp TestMain.cpp
echo ${CXX} ${INC_PATH} -o unit_test.exe *.o ${LIB}

${CXX} ${INC_PATH} -c ${CXX_SOURCES}
${CXX} ${INC_PATH} -c -DTEST_KOKKOS_SPACE=Kokkos::HostSpace TestArrayExp.cpp TestMain.cpp
${CXX} ${INC_PATH} -o unit_test.exe *.o ${LIB}

rm -f *.o *.a

#-----------------------------------------------------------------------------

