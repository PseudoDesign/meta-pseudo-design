FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://pd-issue \
    "

do_install:append:pd-linux() {
    cat pd-issue ${D}${sysconfdir}/issue > ${B}/.pd-issue
    install -m 644 .pd-issue ${D}${sysconfdir}/issue
    install -m 644 .pd-issue ${D}${sysconfdir}/issue.net
}

FILES:${PN} += " ${sysconfdir} "