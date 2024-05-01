# Replace the XSA file with one appropraite for the machine.

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# Design wrapper (.xsa) files should be placed in the "files" subdirectory
# They must be named ${MACHINE}-wrapper.xsa, e.g. "hello-world-zcu102-zynqmp-wrapper.xsa"

HDF_EXT = "xsa"
HDF_BASE = "file://"
HDF_PATH = "${MACHINE}-wrapper.xsa"