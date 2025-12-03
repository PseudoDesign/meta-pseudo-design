do_compile:append:mender-uboot() {
    # The xilinx bootloader is configured to store uboot environment variables in FAT
    echo "/uboot/uboot.env 0x0000 0x4000" > ${WORKDIR}/fw_env.config
    echo "/uboot/uboot-redund.env 0x0000 0x4000" >> ${WORKDIR}/fw_env.config
}
do_compile[depends] += "u-boot:do_deploy"

do_install:append:mender-uboot() {
    # Deploy the initial enviroment file built by uboot-xlnx
    cp ${DEPLOY_DIR_IMAGE}/u-boot-initial-env ${D}${sysconfdir}
}

FILES_${PN} += " \
    ${sysconfdir}/u-boot-initial-env \
"
