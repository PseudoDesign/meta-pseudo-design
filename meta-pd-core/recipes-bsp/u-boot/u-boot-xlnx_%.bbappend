MENDER_UBOOT_AUTO_CONFIGURE = "0"

require recipes-bsp/u-boot/u-boot-mender.inc

FILESEXTRAPATHS:prepend := "${THISDIR}/u-boot-xlnx:"
SRC_URI:append = " file://0001-add-mender-settings.patch file://0001-add-env-in-fat.patch file://0001-change-partition-table-size.patch"


PROVIDES += "u-boot"
RPROVIDES_${PN} += "u-boot"


