#
# This code is meant to be sourced, not executed.
# It currently only supports NERSC hosts.
#
if [[ $(basename ${SHELL}) == "bash" || $(basename ${SHELL}) == "sh" ]]; then
    if [[ $# > 0 ]]; then
        _desi_release="/$1"
    else
        _desi_release=''
    fi
    case ${_desi_release} in
        /17.* | /18.1)
            _desi_startup=/global/common/${NERSC_HOST}/contrib/desi/desiconda/startup/modulefiles
            if [[ "${NERSC_HOST}" == "datatran" ]]; then
                _desi_startup=/global/project/projectdirs/desi/software/${NERSC_HOST}/desiconda/startup/modulefiles
            fi
            ;;
        *)
            _desi_startup=/global/common/software/desi/${NERSC_HOST}/desiconda/startup/modulefiles
            ;;
    esac
    if [[ "${NERSC_HOST}" == "edison" || \
          "${NERSC_HOST}" == "cori" || \
          "${NERSC_HOST}" == "datatran" ]]; then
        module use ${_desi_startup}
        module load desimodules${_desi_release}
    else
        echo "DESI+Anaconda environment is not supported on ${NERSC_HOST}!"
    fi
    unset _desi_startup
    unset _desi_release
else
    echo "You are not sourcing the correct file for your shell!"
fi
