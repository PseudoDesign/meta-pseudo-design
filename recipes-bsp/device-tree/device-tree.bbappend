FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:cora-z7 += " \
    file://0001-remove-cpu1-from-zynq-7000-device-tree-as-the-single.patch \
    file://cora-z7.dtsi \
"

do_configure:append:cora-z7() {
    cp ${WORKDIR}/cora-z7.dtsi ${B}/device-tree
    echo "/include/ \"cora-z7.dtsi\"" >> ${B}/device-tree/system-top.dts
}