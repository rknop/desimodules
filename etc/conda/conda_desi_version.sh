#!/bin/bash

pyversion="$1"
version="$2"

if [ "x${version}" = "x" ]; then
    echo "Usage:  $0 <python version> <version string>"
    exit 1
fi
if [ "x${pyversion}" = "x" ]; then
    echo "Usage:  $0 <python version> <version string>"
    exit 1
fi

prefixpath=""
moddir=""
if [ "x${NERSC_HOST}" = "xdatatran" ]; then
    prefixpath="/project/projectdirs/desi/software/${NERSC_HOST}/conda"
    moddir="${prefixpath}/modulefiles"
else
    prefixpath="/global/common/${NERSC_HOST}/contrib/desi/conda"
    moddir="/global/common/${NERSC_HOST}/contrib/desi/modulefiles"
fi

mkdir -p "${moddir}/desi-conda"
mkdir -p "${moddir}/desi-conda-base"
mkdir -p "${moddir}/desi-conda-extra"

# set default versions

modver="${moddir}/desi-conda/.version"
cat module_version.template | sed \
-e "s#@PYVERSION@#${pyversion}#g" \
-e "s#@VERSION@#${version}#g" \
> ${modver}

modver="${moddir}/desi-conda-base/.version"
cat module_version.template | sed \
-e "s#@PYVERSION@#${pyversion}#g" \
-e "s#@VERSION@#${version}#g" \
> ${modver}

modver="${moddir}/desi-conda-extra/.version"
cat module_version.template | sed \
-e "s#@PYVERSION@#${pyversion}#g" \
-e "s#@VERSION@#${version}#g" \
> ${modver}

# this script should be running as user desi!
chgrp -R desi ${moddir}
chmod -R g+rX,g-w,o-rwx ${moddir}
