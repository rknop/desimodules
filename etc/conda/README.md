Installing Conda-based Tools for DESI
==============================================

Here are the steps to install new dependencies.
For production installs, all operations should
be run as user desi.  You can access that account
from edisongrid.nersc.gov, corigrid.nersc.gov, or
the dtn nodes.

1.  Decide on the "version" string to use for the
installation.  For example, use the date:  20160828.
Also note the python major / minor version: "2.7", 
"3.5", etc.  For this example, assume:

    version="20160828"
    pyversion="3.5"

2.  Run miniconda installer.  This is an interactive
program.  A local copy exists at the path below, but
this should be periodically re-downloaded.  At the 
interactive prompt, enter the install location,
substituting the actual name (e.g. edison, cori) for
"$NERSC_HOST" below.  On cori and edison, install to:

        /global/common/${NERSC_HOST}/contrib/desi/conda/conda_3.5-20160828

    on datatran, install to:

        /project/projectdirs/desi/software/datatran/conda/conda_3.5-20160828

    Here is the command example to run the installer:

        $> bash /project/projectdirs/desi/software/src/conda/Miniconda3-latest-Linux-x86_64.sh

3.  Install module files, and then load them:

        $> ./conda_desi_modules.sh 3.5 20160828
        $> module load desi-conda/3.5-20160828

4.  Install the conda packages we need:

        $> ./conda_desi_pkgs.sh 3.5 20160828

5.  Install the "extra" software we need.  We make a build
    directory and do the build from there in order to avoid
    clutter:

        $> mkdir build
        $> cd build
        $> ../conda_desi_extra.sh 3.5 20160828

6.  (OPTIONAL) Make this version the default:

        $> ./conda_desi_version.sh 3.5 20160828

    DON'T DO THIS UNTIL YOU HAVE TESTED IT WORKS!

