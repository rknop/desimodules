#
# This code is meant to be sourced, not executed.
# It currently only supports NERSC hosts.
#
# $Id$
#
if ( `basename ${SHELL}` == "csh" || `basename ${SHELL}` == "tcsh" ) then
    if ( "${NERSC_HOST}" == "edison" || "${NERSC_HOST}" == "cori" ) then
        module use /global/common/${NERSC_HOST}/contrib/desi/modulefiles
    else if ( "${NERSC_HOST}" == "datatran" || "${NERSC_HOST}" == "scigate" ) then
        module use /global/project/projectdirs/desi/software/${NERSC_HOST}/modulefiles
    else
        echo "DESI+Anaconda environment is not supported on ${NERSC_HOST}!"
    endif
    if ( $# > 0 ) then
        module load desimodules/$1
    else
        module load desimodules
    endif
else
    echo "You are not sourcing the correct file for your shell!"
endif
