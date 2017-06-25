#!/bin/sh

BOARD_DIR="$(dirname $0)"
GENIMAGE_CFG="${BOARD_DIR}/genimage-raspberrypicm3-64.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

# Run a 64bits kernel (armv8)
if ! grep -qE '^arm_control=0x200' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
    cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# enable 64bits support
arm_control=0x200
__EOF__
fi

# Enable uart console
if ! grep -qE '^enable_uart=1' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
    cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# enable rpicm3 ttyS0 serial console
enable_uart=1
__EOF__
fi

cp "${BINARIES_DIR}/Image" "${BINARIES_DIR}/kernel.img"
#
dd if=/dev/zero of="${BINARIES_DIR}/userfs.f2fs" bs=512 count=1048576
mkfs.f2fs "${BINARIES_DIR}/userfs.f2fs"
rm -rf "${GENIMAGE_TMP}"

genimage                           \
	--rootpath "${TARGET_DIR}"     \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"

exit $?
