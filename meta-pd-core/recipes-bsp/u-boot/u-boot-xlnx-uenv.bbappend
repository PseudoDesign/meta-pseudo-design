# Set the root filesystem to the partition mender selects
KERNEL_BOOTARGS:zynq = "earlyprintk console=ttyPS0,115200 root=${mender_kernel_root} rw rootwait"
KERNEL_BOOTARGS:zynqmp = "earlycon root=${mender_kernel_root} rw rootwait"