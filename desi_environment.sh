#
# This code is meant to be sourced, not executed.
# It currently only supports NERSC hosts.
#
if [[ $(basename ${SHELL}) == "bash" || $(basename ${SHELL}) == "sh" ]]; then
    if [[ "${NERSC_HOST}" == "edison" || "${NERSC_HOST}" == "cori" ]]; then
        module use /global/common/${NERSC_HOST}/contrib/desi/desiconda/startup/modulefiles
    elif [[ "${NERSC_HOST}" == "datatran" || "${NERSC_HOST}" == "scigate" ]]; then
        module use /global/project/projectdirs/desi/software/${NERSC_HOST}/desiconda/startup/modulefiles
    else
        echo "DESI+Anaconda environment is not supported on ${NERSC_HOST}!"
    fi
    if [[ $# > 0 ]]; then
        module load desimodules/$1
    else
        module load desimodules
    fi
else
    echo "You are not sourcing the correct file for your shell!"
fi
