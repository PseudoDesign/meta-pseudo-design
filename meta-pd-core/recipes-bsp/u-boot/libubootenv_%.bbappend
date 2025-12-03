do_compile:append:mender-uboot() {
    # The xilinx bootloader is configured to store uboot environment variables in FAT
    echo "/uboot/uboot.env 0x0000 0x4000" > ${WORKDIR}/fw_env.config
    echo "/uboot/uboot-redund.env 0x0000 0x4000" >> ${WORKDIR}/fw_env.config
}
do_compile[depends] += "u-boot:do_deploy"
