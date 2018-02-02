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

In preparation for a software release:

1. Edit the ``test-release`` with the desired versions.
2. Load the ``test-release`` environment and run tests.
3. When the tests pass, copy ``test-release`` to a new file, *e.g.* ``18.3``,
   and edit the version information.
4. Add the new file.
5. Tag this package with the name of the new file.
