# Append our XSA files to the HDF parsing recipe.  These are selected via variables in the machine.conf file.

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

HDF_URI:cora-z7 = "file://cora-z7.xsa"