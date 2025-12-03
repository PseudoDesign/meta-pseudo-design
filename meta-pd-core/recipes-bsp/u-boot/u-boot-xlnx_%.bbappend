MENDER_UBOOT_AUTO_CONFIGURE = "0"
BOOTENV_SIZE ?= "0x4000"
# explicitly set the name to ensure file is packaged without the "-xlnx" suffix.
UBOOT_INITIAL_ENV = "u-boot-initial-env"
require recipes-bsp/u-boot/u-boot-mender.inc

FILESEXTRAPATHS:prepend := "${THISDIR}/u-boot-xlnx:"
SRC_URI:append = " file://0001-add-mender-settings.patch file://0002-add-env-in-fat.patch file://0003-change-partition-table-size.patch "


PROVIDES += "u-boot"
RPROVIDES_${PN} += "u-boot"

