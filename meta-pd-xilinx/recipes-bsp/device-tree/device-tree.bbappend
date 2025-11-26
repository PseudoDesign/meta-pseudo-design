FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:cora-z7 += " \
    file://cora-z7.dtsi \
    file://0001-remove-cpu1.patch \
"

do_configure:append:cora-z7() {
    cp ${WORKDIR}/cora-z7.dtsi ${B}/device-tree
    echo "/include/ \"cora-z7.dtsi\"" >> ${B}/device-tree/system-top.dts
}

