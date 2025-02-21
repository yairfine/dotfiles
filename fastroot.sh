#!/bin/sh -e
if [ -z "$1" ]; then
	echo "Usage: $0 file [prefix]"
	exit 1
fi

if [ -z "$2" ]; then
	PREFIX=/
else
	PREFIX=$2/
fi

realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

CURR_PATH=$(pwd)

TMP_DIR=$(mktemp -d)
rm -rf ${TMP_DIR}

TARGET_DIR="${TMP_DIR}/${PREFIX}"
mkdir -p ${TARGET_DIR}

cp -R $1 ${TARGET_DIR}

pushd ${TMP_DIR}
tar -cvzf ${CURR_PATH}/root.tar.gz ./*
popd
