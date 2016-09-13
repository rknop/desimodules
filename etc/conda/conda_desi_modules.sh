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
basetemp=""
if [ "x${NERSC_HOST}" = "xdatatran" ]; then
    prefixpath="/project/projectdirs/desi/software/${NERSC_HOST}/conda"
    moddir="${prefixpath}/modulefiles"
    basetemp="module_conda-base-dtn.template"
else
    prefixpath="/global/common/${NERSC_HOST}/contrib/desi/conda"
    moddir="/global/common/${NERSC_HOST}/contrib/desi/modulefiles"
    basetemp="module_conda-base.template"
fi

mkdir -p "${moddir}/desi-conda"
mkdir -p "${moddir}/desi-conda-base"
mkdir -p "${moddir}/desi-conda-extra"

modfile="${moddir}/desi-conda/${pyversion}-${version}"
modbasefile="${moddir}/desi-conda-base/${pyversion}-${version}"
modextrafile="${moddir}/desi-conda-extra/${pyversion}-${version}"

# conda base module

prefix="${prefixpath}/conda_${pyversion}-${version}"
mkdir -p "${prefix}/bin"
mkdir -p "${prefix}/lib/python${pyversion}/site-packages"

cat ${basetemp} | sed \
-e "s#@PROJECT@#desi#g" \
-e "s#@PREFIX@#${prefix}#g" \
-e "s#@VERSION@#${version}#g" \
-e "s#@PYVERSION@#${pyversion}#g" \
> ${modbasefile}

cat module_conda.template | sed \
-e "s#@PROJECT@#desi#g" \
-e "s#@PREFIX@#${prefix}#g" \
-e "s#@VERSION@#${version}#g" \
-e "s#@PYVERSION@#${pyversion}#g" \
> ${modfile}

# conda extra module

prefix="${prefixpath}/conda_${pyversion}-${version}_extra"
mkdir -p "${prefix}/bin"
mkdir -p "${prefix}/include"
mkdir -p "${prefix}/lib/python${pyversion}/site-packages"

cat module_conda-extra.template | sed \
-e "s#@PROJECT@#desi#g" \
-e "s#@PREFIX@#${prefix}#g" \
-e "s#@VERSION@#${version}#g" \
-e "s#@PYVERSION@#${pyversion}#g" \
> ${modextrafile}

# set default versions

modver="${moddir}/desi-conda/.version"
cat module_version.template | sed \
-e "s#@VERSION@#${version}#g" \
> ${modver}

modver="${moddir}/desi-conda-base/.version"
cat module_version.template | sed \
-e "s#@VERSION@#${version}#g" \
> ${modver}

modver="${moddir}/desi-conda-extra/.version"
cat module_version.template | sed \
-e "s#@VERSION@#${version}#g" \
> ${modver}

# this script should be running as user desi!
chgrp -R desi ${moddir}
chmod -R g+rX,g-w,o-rwx ${moddir}
