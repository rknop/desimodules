#
# This code is meant to be sourced, not executed.
# It currently only supports NERSC hosts.
#
if [[ $(basename ${SHELL}) == "bash" || $(basename ${SHELL}) == "sh" ]]; then
    if [[ $# > 0 ]]; then
        release="/$1"
    else
        release=''
    fi
    case ${release} in
        /17.* | /18.1)
            startup=/global/common/${NERSC_HOST}/contrib/desi/desiconda/startup/modulefiles
            if [[ "${NERSC_HOST}" == "datatran" ]]; then
                startup=/global/project/projectdirs/desi/software/${NERSC_HOST}/desiconda/startup/modulefiles
            fi
            ;;
        *)
            startup=/global/common/software/desi/${NERSC_HOST}/desiconda/startup/modulefiles
            ;;
    esac
    if [[ "${NERSC_HOST}" == "edison" || \
          "${NERSC_HOST}" == "cori" || \
          "${NERSC_HOST}" == "datatran" ]]; then
        module use ${startup}
        module load desimodules${release}
    else
        echo "DESI+Anaconda environment is not supported on ${NERSC_HOST}!"
    fi
    unset startup
    unset release
else
    echo "You are not sourcing the correct file for your shell!"
fi
