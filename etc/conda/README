Here are the steps to install new dependencies.
Do all operations as user desi!!!

0.  Decide on the "version" string.  For example,
use the date:  20160828.  Also note the python
version: "2.7", "3.5", etc.  For this example,
assume:

    version="20160828"
    pyversion="3.5"

1.  Run miniconda installer as user desi, and 
install to:

    /global/common/${NERSC_HOST}/contrib/desi/conda/conda_3.5-20160828

    $> bash /project/projectdirs/desi/software/src/conda/Miniconda3-latest-Linux-x86_64.sh

2.  Install module files, and then load them:

    $> ./conda_desi_modules.sh 3.5 20160828
    $> module load desi-conda/3.5-20160828

3.  Install the conda packages we need:

    $> ./conda_desi_pkgs.sh 3.5 20160828

4.  Install the "extra" software we need:

    $> ./conda_desi_extra.sh 3.5 20160828

5.  (OPTIONAL) Make this version the default:

    $> ./conda_desi_version.sh 3.5 20160828

    DON'T DO THIS UNTIL YOU HAVE TESTED IT WORKS!
