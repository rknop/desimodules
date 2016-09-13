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
if [ "x${NERSC_HOST}" = "xdatatran" ]; then
    prefixpath="/project/projectdirs/desi/software/${NERSC_HOST}/conda"
else
    prefixpath="/global/common/${NERSC_HOST}/contrib/desi/conda"
fi

prefix="${prefixpath}/conda_${pyversion}-${version}"

pkgs="\
requests \
numpy \
scipy \
matplotlib \
pyyaml \
astropy \
h5py \
ipython-notebook \
psutil \
scikit-image \
scikit-learn \
"

com="conda install --yes ${pkgs}"
echo "${com}"
eval ${com}

# for p in ${pkgs}; do
#     com="conda install --yes ${p}"
#     echo "${com}"
#     eval ${com}
# done

pips="\
fitsio \
speclite \
iniparser \
hpsspy \
"

for p in ${pips}; do
    com="pip install --no-binary :all: ${p}"
    echo "${com}"
    eval ${com}
done

# recompile all pyc files
python -m compileall -f ${prefix}

# do final dump of package list and set permissions

conda list --export | grep -v conda > ${prefix}/pkg_list.txt

chgrp -R desi ${prefix}
chmod -R g+rX,g-w,o-rwx ${prefix}

