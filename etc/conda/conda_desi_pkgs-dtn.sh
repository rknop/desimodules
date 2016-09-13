#!/bin/bash

pkgs="\
requests \
numpy \
scipy \
matplotlib \
pyyaml \
astropy \
h5py \
ipython-notebook \
mpi4py \
"

for p in ${pkgs}; do
    com="conda install ${p}"
    echo "${com}"
    eval ${com}
done

pips="\
fitsio \
speclite \
iniparser \
hpsspy \
"

for p in ${pips}; do
    com="pip install ${p}"
    echo "${com}"
    eval ${com}
done

