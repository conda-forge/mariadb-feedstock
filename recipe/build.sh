#!/bin/bash

set -euxo pipefail

export MARIADB_CC_LIB="${PREFIX}/lib/mariadb"
export MARIADB_CC_LIBRARY="${PREFIX}/include/mariadb"

export PATH="$MARIADB_CC_LIB:$MARIADB_CC_LIBRARY:${PATH}"
export MARIADB_CONFIG="${PREFIX}/bin/mariadb_config"

if [[ "$TARGET_PLATFORM" == "osx-arm64" ]]; then
	export CC="$CC:arm64-apple-darwin20.0.0-clang"
fi

${PYTHON} setup.py build
${PYTHON} -m pip install . -vv --no-deps --no-build-isolation
