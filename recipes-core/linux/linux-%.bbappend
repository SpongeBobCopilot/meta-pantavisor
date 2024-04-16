
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

PANTAVISOR_SRC_URI = " \
	file://overlayfs.cfg \
	file://pantavisor.cfg \
	file://pvcrypt.cfg \
	file://pvnocma.cfg \
	file://dm.cfg \
	${@bb.utils.contains('PANTAVISOR_FEATURES', 'squash-lz4', 'file://pantavisor-lz4.cfg', '', d)} \
"


PANTAVISOR_KERNEL_FRAGMENTS = " \
	${WORKDIR}/pantavisor.cfg \
	${WORKDIR}/pvcrypt.cfg \
	${WORKDIR}/pvnocma.cfg \
	${WORKDIR}/overlayfs.cfg \
	${WORKDIR}/dm.cfg \
	${@bb.utils.contains('PANTAVISOR_FEATURES', 'squash-lz4', '${WORKDIR}/pantavisor-lz4.cfg', '', d)} \
"

SRC_URI:append = " \
	${@bb.utils.contains('DISTRO_FEATURES', 'pantavisor-system', '${PANTAVISOR_SRC_URI}', '', d)} \
"

KERNEL_CONFIG_FRAGMENTS:append = " \
	${@bb.utils.contains('DISTRO_FEATURES', 'pantavisor-system', '${PANTAVISOR_KERNEL_FRAGMENTS}', '', d)} \
"

COMPATIBLE_MACHINE:qemuarm-pv = "qemuarm-pv"