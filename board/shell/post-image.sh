#!/bin/sh

dd if=/dev/zero of="${BINARIES_DIR}/userfs.f2fs" bs=512 count=131072
mkfs.f2fs "${BINARIES_DIR}/userfs.f2fs"
BOARD_DIR="$(dirname $0)"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"
rm -rf "${GENIMAGE_TMP}"
GENIMAGE_CFG="${BOARD_DIR}/genimage-raspberrypicm3-64.cfg"
genimage                           \
	--rootpath "${TARGET_DIR}"     \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"

exit $?
