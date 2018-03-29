#
# This code is meant to be sourced, not executed.
# It currently only supports NERSC hosts.
#
if ( `basename ${SHELL}` == "csh" || `basename ${SHELL}` == "tcsh" ) then
    if ( $# > 0 ) then
        set release = "/$1"
    else
        set release = ''
    endif
    switch ( ${release} )
        case "/17.*":
        case '/18.1':
            set startup = /global/common/${NERSC_HOST}/contrib/desi/desiconda/startup/modulefiles
            if ( "${NERSC_HOST}" == "datatran" ) then
                set startup = /global/project/projectdirs/desi/software/${NERSC_HOST}/desiconda/startup/modulefiles
            endif
            breaksw
        default:
            set startup = /global/common/software/desi/${NERSC_HOST}/desiconda/startup/modulefiles
            breaksw
    endsw
    if ( "${NERSC_HOST}" == "edison" || \
         "${NERSC_HOST}" == "cori" || \
         "${NERSC_HOST}" == "datatran" ) then
        module use ${startup}
        module load desimodules${release}
    else
        echo "DESI+Anaconda environment is not supported on ${NERSC_HOST}!"
    endif
    unset startup
    unset release
else
    echo "You are not sourcing the correct file for your shell!"
endif
