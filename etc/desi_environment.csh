#
# This code is meant to be sourced, not executed.
# It currently only supports NERSC hosts.
#
# $Id$
#
if ( `basename ${SHELL}` == "csh" || `basename ${SHELL}` == "tcsh" ) then
    source /project/projectdirs/cmb/modules/hpcports_NERSC.csh
    if ( "${NERSC_HOST}" == "edison" ) then
        hpcports shared_gnu
    endif
    if ( "${NERSC_HOST}" == "cori" ) then
        hpcports gnu
    endif
    if ( "${NERSC_HOST}" == "hopper" )  then
        hpcports shared_gnu
    endif
    if ( "${NERSC_HOST}" == "datatran" || "${NERSC_HOST}" == "scigate" ) then
        hpcports
    endif
    if ( -d /project/projectdirs/desi/software/modules/${NERSC_HOST} ) then
        module use /project/projectdirs/desi/software/modules/${NERSC_HOST}

        if ( $# > 0 ) then
            module load desimodules/$1
        else
            module load desimodules
        endif
    else
        echo "Could not find DESI modules for ${NERSC_HOST}!"
    endif
else
    echo "You are not sourcing the correct file for your shell!"
endif
