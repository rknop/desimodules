#
# This code is meant to be sourced, not executed.
# It currently only supports NERSC hosts.
#
if ( `basename ${SHELL}` == "csh" || `basename ${SHELL}` == "tcsh" ) then
    if ( $# > 0 ) then
        set desiconda_version = $1
    else
        set desiconda_version = current
    endif
    if ( $# > 1 ) then
        set desimodules_version = "/$2"
    else
        set desimodules_version = ''
    endif
    if ( "${NERSC_HOST}" == "edison" || "${NERSC_HOST}" == "cori" ) then
        module use /global/common/${NERSC_HOST}/contrib/desi/${desiconda_version}/modulefiles
    else if ( "${NERSC_HOST}" == "datatran" || "${NERSC_HOST}" == "scigate" ) then
        module use /global/project/projectdirs/desi/software/${NERSC_HOST}/${desiconda_version}/modulefiles
    else
        echo "DESI+Anaconda environment is not supported on ${NERSC_HOST}!"
    endif
    module load "desimodules${desimodules_version}"
else
    echo "You are not sourcing the correct file for your shell!"
endif
