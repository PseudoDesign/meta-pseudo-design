SUMMARY = "Configuration for the data partition in pseudo-design-linux"
LICENSE = "MIT"
PV = "1.0"

S = "${WORKDIR}"

do_install () {
        install -d ${D}/mnt/data
        touch ${D}/mnt/data
}

FILES_${PN} = "/mnt/data"