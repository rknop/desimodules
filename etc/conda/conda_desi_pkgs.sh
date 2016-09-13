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
psutil \
scikit-image \
scikit-learn \
"

for p in ${pkgs}; do
    com="conda install --yes ${p}"
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

