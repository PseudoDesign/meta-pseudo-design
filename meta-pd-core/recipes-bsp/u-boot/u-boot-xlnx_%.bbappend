MENDER_UBOOT_AUTO_CONFIGURE = "0"

require recipes-bsp/u-boot/u-boot-mender.inc

FILESEXTRAPATHS:prepend := "${THISDIR}/u-boot-xlnx:"
SRC_URI:append = " file://0001-add-mender-config-for-xilinx-defconfig.patch"


PROVIDES += "u-boot"
RPROVIDES_${PN} += "u-boot"