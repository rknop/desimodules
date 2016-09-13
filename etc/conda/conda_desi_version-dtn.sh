#!/bin/bash

pyversion="$1"
version="$2"

prjpath="/project/projectdirs/desi/software/${NERSC_HOST}/conda"
moddir="${prjpath}/modulefiles"

if [ "x${version}" = "x" ]; then
    echo "Usage:  $0 <python version> <version string>"
    exit 1
fi
if [ "x${pyversion}" = "x" ]; then
    echo "Usage:  $0 <python version> <version string>"
    exit 1
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

