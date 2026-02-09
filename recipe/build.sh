#!/bin/bash

set -euxo pipefail

export MARIADB_CC_LIB="${PREFIX}/lib/mariadb"
export MARIADB_CC_LIBRARY="${PREFIX}/include/mariadb"

export PATH="$MARIADB_CC_LIB:$MARIADB_CC_LIBRARY:${PATH}"
export MARIADB_CONFIG="${PREFIX}/bin/mariadb_config"

if [[ "${target_platform}" == "osx-arm64" ]]; then
	export CXXFLAGS="$CXXFLAGS --cc -arch arm64"
	export CFLAGS="$CFLAGS -arch arm64"
fi

${PYTHON} setup.py build
${PYTHON} -m pip install . -vvv --no-deps --no-build-isolation --no-cache-dir
