#
# This code is meant to be sourced, not executed.
# It currently only supports NERSC hosts.
#
# $Id$
#
if [[ $(basename ${SHELL}) == "bash" || $(basename ${SHELL}) == "sh" ]]; then
    source /project/projectdirs/cmb/modules/hpcports_NERSC.sh
    if [[ "${NERSC_HOST}" == "edison" ]]; then
        hpcports shared_gnu
    fi
    if [[ "${NERSC_HOST}" == "hopper" ]]; then
        hpcports shared_gnu
    fi
    if [[ "${NERSC_HOST}" == "carver" ]]; then
        #- On carver, check if we are Scientific Linux 5, 6, or default
        if [[ "${CHOS}" != "sl6carver" ]]; then
            echo "ERROR: The DESI environment requires Scientific Linux 6 (SL6) on carver."
            echo "Please switch to SL6 first by creating a .chos-carver file in your home"
            echo "directory with contents \"sl6carver\" and then login again;"
            echo "or run \"export CHOS=sl6carver; chos bash -l\" to temporarily switch to SL6."
            echo
            echo "For more details about CHOS and SL5 vs SL6 on carver, see"
            echo "https://www.nersc.gov/users/computational-systems/carver/user-environment/"
            echo
            echo "After switching to SL6, source desi_environment.sh again."
            return
        fi
        hpcports gnu
    fi
    if [[ "${NERSC_HOST}" == "datatran" || "${NERSC_HOST}" == "scigate" ]]; then
        hpcports
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
