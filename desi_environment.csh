#
# This code is meant to be sourced, not executed.
# It currently only supports NERSC hosts.
#
if ( `basename ${SHELL}` == "csh" || `basename ${SHELL}` == "tcsh" ) then
    if ( $# > 0 ) then
        set _desi_release = "/$1"
    else
        set _desi_release = ''
    endif
    switch ( ${_desi_release} )
        case "/17.*":
        case '/18.1':
            set _desi_startup = /global/common/${NERSC_HOST}/contrib/desi/desiconda/startup/modulefiles
            if ( "${NERSC_HOST}" == "datatran" ) then
                set _desi_startup = /global/project/projectdirs/desi/software/${NERSC_HOST}/desiconda/startup/modulefiles
            endif
            breaksw
        default:
            set _desi_startup = /global/common/software/desi/${NERSC_HOST}/desiconda/startup/modulefiles
            breaksw
    endsw
    if ( ${?DESI_ROOT} ) then
        # Do nothing, successfully.
        :
    else if ( ${?NERSC_HOST} ) then
        setenv DESI_ROOT /global/cfs/cdirs/desi
    else
        echo "Could not determine a valid value of DESI_ROOT!"
        exit
    endif
    if ( "${NERSC_HOST}" == "perlmutter" || \
         "${NERSC_HOST}" == "cori" || \
         "${NERSC_HOST}" == "datatran" ) then
        module use ${_desi_startup}
        module load desimodules${_desi_release}
    else
        echo "DESI+Anaconda environment is not supported on ${NERSC_HOST}!"
    endif
    unset _desi_startup
    unset _desi_release
else
    echo "You are not sourcing the correct file for your shell!"
endif
