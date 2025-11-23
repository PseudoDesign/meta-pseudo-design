require recipes-bsp/u-boot/u-boot-mender.inc

FILESEXTRAPATHS:prepend := "${THISDIR}/u-boot-xlnx:"


PROVIDES += "u-boot"
RPROVIDES_${PN} += "u-boot"