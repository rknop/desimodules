#!/bin/bash

pyversion="$1"
version="$2"

prjpath="/project/projectdirs/desi/software/${NERSC_HOST}/conda"

if [ "x${version}" = "x" ]; then
    echo "Usage:  $0 <python version> <version string>"
    exit 1
fi
if [ "x${pyversion}" = "x" ]; then
    echo "Usage:  $0 <python version> <version string>"
    exit 1
fi

prefix="${prjpath}/conda_${pyversion}-${version}_extra"

# 2 or 3
ver=`echo ${pyversion} | cut -c1`

python="python"
pyconfig="python-config"
if [ "${ver}" != "2" ]; then
    python="python${ver}"
    pyconfig="python${ver}-config"
fi

export CC="gcc"
export CXX="g++"
export FC="gfortran"
export CFLAGS="-O3 -fPIC"
export CXXFLAGS="-O3 -fPIC"
export FCFLAGS="-O3 -fPIC"

blas="-L${prefix}/lib -lopenblas"
lapack=""

src="/project/projectdirs/desi/software/src/conda"
jmake="-j 4"

dir=`pwd`

# OpenBLAS

pkg="openblas"
log="${dir}/log.${pkg}"
dn="${dir}/done.${pkg}"
if [ ! -e ${dn} ]; then
    echo "extracting ${pkg}"
    tar xzvf "${src}/openblas-0.2.18.tar.gz" >${log} 2>&1
    cd OpenBLAS-0.2.18
    echo "configuring ${pkg}"
    echo "building ${pkg}"
    make >>${log} 2>&1
    make install PREFIX="${prefix}" >>${log} 2>&1
    cd ..
    touch ${dn}
fi

# CFITSIO

pkg="cfitsio"
log="${dir}/log.${pkg}"
dn="${dir}/done.${pkg}"
if [ ! -e ${dn} ]; then
    echo "extracting ${pkg}"
    tar xzvf "${src}/cfitsio3390.tar.gz" >${log} 2>&1
    cd cfitsio
    echo "configuring ${pkg}"
    ./configure --prefix=${prefix} >>${log} 2>&1
    echo "building ${pkg}"
    make ${jmake} >>${log} 2>&1
    make shared >>${log} 2>&1
    make install >>${log} 2>&1
    cd ..
    touch ${dn}
fi

# FFTW

pkg="fftw"
log="${dir}/log.${pkg}"
dn="${dir}/done.${pkg}"
if [ ! -e ${dn} ]; then
    echo "extracting ${pkg}"
    tar xzvf "${src}/fftw-3.3.5.tar.gz" >${log} 2>&1
    cd fftw-3.3.5
    echo "configuring ${pkg}"
    ./configure --enable-threads --enable-mpi --prefix=${prefix} >>${log} 2>&1
    echo "building ${pkg}"
    make ${jmake} >>${log} 2>&1
    make install >>${log} 2>&1
    cd ..
    touch ${dn}
fi

# BOOST

pkg="boost"
log="${dir}/log.${pkg}"
dn="${dir}/done.${pkg}"
if [ ! -e ${dn} ]; then
    echo "extracting ${pkg}"
    tar xjvf "${src}/boost_1_61_0.tar.bz2" >${log} 2>&1
    cd boost_1_61_0
    echo "configuring ${pkg}"
    cat > tools/build/user-config.jam <<EOF
using gcc : : ${CXX} : <cflags>"${CFLAGS}" <cxxflags>"${CXXFLAGS}" ;
EOF
    echo "building ${pkg}"
    pyinclude=`${pyconfig} --includes | sed -e 's/-I//g' -e 's/\([^[:space:]]\+\)/ include=\1/g'`
    BOOST_BUILD_USER_CONFIG=tools/build/user-config.jam ./bootstrap.sh --with-toolset=gcc --with-python=${python} --prefix=${prefix} >>${log} 2>&1
    BOOST_BUILD_USER_CONFIG=tools/build/user-config.jam ./b2 --layout=tagged ${pyinclude} variant=release threading=multi link=shared runtime-link=shared install >>${log} 2>&1
    cd ..
    touch ${dn}
fi

# HARP

pkg="harp"
log="${dir}/log.${pkg}"
dn="${dir}/done.${pkg}"
if [ ! -e ${dn} ]; then
    echo "extracting ${pkg}"
    tar xzvf "${src}/harp-1.0.1.tar.gz" >${log} 2>&1
    cd harp-1.0.1
    echo "configuring ${pkg}"
    LIBS='-ldl' ./configure --disable-python --disable-mpi --with-boost=${prefix} --with-cfitsio=${prefix} --with-blas="${blas}" --prefix=${prefix} >>${log} 2>&1
    echo "building ${pkg}"
    make ${jmake} >>${log} 2>&1
    make install >>${log} 2>&1
    cd ..
    touch ${dn}
fi

# libtool files can cause problems some times...

rm -f ${prefix}/lib/*.la

# this script should be running as user desi!

chgrp -R desi ${prefix}
chmod -R g+rX,o-rwx ${prefix}

prefix="${prjpath}/conda_${pyversion}-${version}"

chgrp -R desi ${prefix}
chmod -R g+rX,o-rwx ${prefix}

