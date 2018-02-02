===========
desimodules
===========

This package provides a meta-module that can be used to load a default
set of DESI modules.

This package is specifically designed to be a valid Modules directory on
its own.  To install this package, all that is required is::

    cd modulefiles
    git clone https://github.com/desihub/desimodules.git

and the modules defined here will appear, assuming the ``modulefiles`` directory
has been added with a ``module use`` command.
