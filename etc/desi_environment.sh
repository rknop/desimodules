#
# This code is meant to be sourced, not executed.
# It currently only supports NERSC hosts.
#
# $Id$
#
if [[ $(basename ${SHELL}) == "bash" || $(basename ${SHELL}) == "sh" ]]; then
    if [[ "${NERSC_HOST}" == "edison" || "${NERSC_HOST}" == "cori" ]]; then
        module use /global/common/${NERSC_HOST}/contrib/desi/modulefiles
    else
        echo "DESI conda environment is not supported on ${NERSC_HOST}!"
    fi
    if [[ -d /project/projectdirs/desi/software/modules/${NERSC_HOST} ]]; then
        module use /project/projectdirs/desi/software/modules/${NERSC_HOST}
        if [[ $# > 0 ]]; then
            module load desimodules/$1
        else
            module load desimodules
        fi
    else
        echo "Could not find DESI modules for ${NERSC_HOST}!"
    fi
else
    echo "You are not sourcing the correct file for your shell!"
fi
