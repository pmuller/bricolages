#!/usr/bin/env bash

set -eux

PREFIX=$(readlink -f $1)

SETUPTOOLS_URL=https://pypi.python.org/packages/source/s/setuptools/setuptools-18.4.tar.gz
PIP_URL=https://pypi.python.org/packages/source/p/pip/pip-7.1.2.tar.gz
VIRTUALENV_URL=https://pypi.python.org/packages/source/v/virtualenv/virtualenv-13.1.2.tar.gz
ARGPARSE_URL=https://pypi.python.org/packages/source/a/argparse/argparse-1.4.0.tar.gz
PROCFS_URL=https://pypi.python.org/packages/source/p/procfs/procfs-0.5.0.tar.gz

PYTHON_MAJOR_MINOR=$(python -c 'import sys; print ".".join(map(str, sys.version_info[:2]))')
PYTHONPATH=$PREFIX/lib/python$PYTHON_MAJOR_MINOR/site-packages
export PYTHONPATH
mkdir -p $PYTHONPATH

_install()
{
    local URL=$1
    local PREFIX=$2
    local TMPDIR=$(mktemp -d)
    local FILENAME=$(basename $URL)

    cd $TMPDIR
    curl -O $URL
    tar xvaf $FILENAME
    rm $FILENAME
    cd *
    python setup.py install --prefix=$PREFIX
    cd /
    rm -rf $TMPDIR
}


_install $SETUPTOOLS_URL $PREFIX
#_install $PIP_URL $PREFIX
#_install $VIRTUALENV_URL $PREFIX
_install $ARGPARSE_URL $PREFIX
_install $PROCFS_URL $PREFIX
