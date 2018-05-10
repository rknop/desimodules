#!/bin/sh
#
# Licensed under a 3-clause BSD style license - see LICENSE.rst
#
# Install a Jupyter kernel definition in a user's home directory.
#
function usage() {
    local execName=$(basename $0)
    (
    echo "${execName} [-h] [-v] RELEASE"
    echo ""
    echo "Install a Jupyter kernel definition."
    echo ""
    echo "        -h = Print this message and exit."
    echo "        -v = Verbose mode. Print extra information for debugging."
    echo "   RELEASE = Name of software release. Required."
    ) >&2
}
#
# Get options
#
verbose=False
while getopts hv argname; do
    case ${argname} in
        h) usage; exit 0 ;;
        v) verbose=True ;;
        *) usage; exit 1 ;;
    esac
done
shift $((OPTIND - 1))
#
# Make sure release actually exists.
#
if [ $# -lt 1 ]; then
    echo "You must specify a release!" >&2
    usage
    exit 1
fi
[ "${verbose}" = "True" ] && echo "release=$1"
release=$1
if [ -z "${DESIMODULES}" ]; then
    echo "The DESIMODULES environment variable does not appear to be set!" >&2
    exit 1
fi
if [ ! -f ${DESIMODULES}/${release} ]; then
    echo "Release ${release} does not appear to exist!" >&2
    exit 1
fi
[ "${verbose}" = "True" ] && echo mkdir -p ${HOME}/.local/share/jupyter/kernels
# mkdir -p ${HOME}/.local/share/jupyter/kernels
echo $SHELL
