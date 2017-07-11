#
# This code is meant to be sourced, not executed.
# It currently only supports NERSC hosts.
#
if [[ $(basename ${SHELL}) == "bash" || $(basename ${SHELL}) == "sh" ]]; then
    if [[ $# > 0 ]]; then
        desiconda_version=$1
    else
        desiconda_version=current
    fi
    if [[ $# > 1 ]]; then
        desimodules_version="/$2"
    else
        desimodules_version=''
    fi
    if [[ "${NERSC_HOST}" == "edison" || "${NERSC_HOST}" == "cori" ]]; then
        module use /global/common/${NERSC_HOST}/contrib/desi/${desiconda_version}/modulefiles
    elif [[ "${NERSC_HOST}" == "datatran" || "${NERSC_HOST}" == "scigate" ]]; then
        module use /global/project/projectdirs/desi/software/${NERSC_HOST}/${desiconda_version}/modulefiles
    else
        echo "DESI+Anaconda environment is not supported on ${NERSC_HOST}!"
    fi
    module load "desimodules${desimodules_version}"
else
    echo "You are not sourcing the correct file for your shell!"
fi
