#
# Copyright (c) 2013-2014, ARM Limited and Contributors. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# Redistributions of source code must retain the above copyright notice, this
# list of conditions and the following disclaimer.
#
# Redistributions in binary form must reproduce the above copyright notice,
# this list of conditions and the following disclaimer in the documentation
# and/or other materials provided with the distribution.
#
# Neither the name of ARM nor the names of its contributors may be used
# to endorse or promote products derived from this software without specific
# prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#

PLAT_INCLUDES		:=	-Iplat/${PLAT}/include/

PLAT_BL_COMMON_SOURCES	:=	drivers/arm/serial/serial.c		\
				drivers/io/io_fip.c               \
				drivers/io/io_memmap.c            \
				lib/mmio.c                        \
				lib/aarch64/sysreg_helpers.S      \
				plat/common/aarch64/plat_common.c \
				plat/${PLAT}/plat_io_storage.c

BL1_SOURCES		+=	drivers/arm/cci400/cci400.c			\
				plat/common/aarch64/platform_up_stack.S \
				plat/${PLAT}/bl1_plat_setup.c           \
				plat/${PLAT}/aarch64/bl1_plat_helpers.S \
				plat/${PLAT}/aarch64/plat_helpers.S     \
				plat/${PLAT}/aarch64/common.c

BL2_SOURCES		+=	lib/locks/bakery/bakery_lock.c		\
				plat/common/aarch64/platform_up_stack.S \
				plat/${PLAT}/bl2_plat_setup.c           \
				plat/${PLAT}/mhu.c                      \
				plat/${PLAT}/aarch64/plat_helpers.S     \
				plat/${PLAT}/aarch64/cache.S            \
				plat/${PLAT}/aarch64/common.c           \
				plat/${PLAT}/scp_bootloader.c           \
				plat/${PLAT}/scpi.c                     \
				plat/${PLAT}/storage.c                  \
				plat/${PLAT}/sha2.c                     \
				plat/${PLAT}/mailbox.c                  \
				plat/${PLAT}/watchdog.c                 \
				plat/${PLAT}/efuse.c                    \
				plat/${PLAT}/pll.c                      \
				plat/${PLAT}/timer.c                    \
				plat/${PLAT}/crypto/secureboot.c        \
				plat/${PLAT}/ddr/ddr.c

BL31_SOURCES		+=	drivers/arm/cci400/cci400.c		\
				drivers/arm/gic/gic_v2.c                \
				plat/common/aarch64/platform_mp_stack.S \
				plat/${PLAT}/bl31_plat_setup.c          \
				plat/${PLAT}/mhu.c                      \
				plat/${PLAT}/aarch64/plat_helpers.S     \
				plat/${PLAT}/aarch64/common.c           \
				plat/${PLAT}/plat_pm.c                  \
				plat/${PLAT}/plat_topology.c            \
				plat/${PLAT}/plat_gic.c                 \
				plat/${PLAT}/scpi.c                     \
				plat/${PLAT}/smc_arm.c

ifeq ($(CONFIG_AML_SECURE_UBOOT),y)
	BL2_SOURCES += plat/${PLAT}/crypto/rsa.c            \
				plat/${PLAT}/crypto/bignum.c
endif

ifeq ($(CONFIG_AML_NAND),y)
	BL2_SOURCES += plat/${PLAT}/nand.c
endif


ifneq (${RESET_TO_BL31},0)
  $(error "Using BL3-1 as the reset vector is not supported on PLAT. \
  Please set RESET_TO_BL31 to 0.")
endif