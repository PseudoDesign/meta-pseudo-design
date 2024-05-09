# Define the 'pseudo-design-sd' conversion type
#
# This conversion type pads any image to the 512K boundary to ensure that the
# image file can be used directly with QEMU's SD emulation which requires the
# block device to match that of valid SD card sizes (which are multiples of
# 512K).

CONVERSIONTYPES_append = " pseudo-design-sd"
CONVERSION_CMD_pseudo-design-sd = "cp ${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.${type} ${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.${type}.pseudo-design-sd; truncate -s %256M ${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.${type}.pseudo-design-sd"
CONVERSION_DEPENDS_pseudo-design-sd = "coreutils-native"
