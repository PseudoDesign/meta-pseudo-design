# Replace the XSA file with one appropraite for the machine.

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# Design wrapper (.xsa) files should be placed in the "files" subdirectory

HDF_EXT = "xsa"
HDF_BASE = "file://"


HDF_PATH_hello-world-zcu102-zynqmp = "hello-world-zcu102-wrapper.xsa"