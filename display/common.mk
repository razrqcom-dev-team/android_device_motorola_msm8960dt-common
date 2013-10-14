#Common headers
common_includes := device/motorola/msm8960dt-common/display/libgralloc
common_includes += device/motorola/msm8960dt-common/display/liboverlay
common_includes += device/motorola/msm8960dt-common/display/libcopybit
common_includes += device/motorola/msm8960dt-common/display/libqdutils
common_includes += device/motorola/msm8960dt-common/display/libhwcomposer
common_includes += device/motorola/msm8960dt-common/display/libexternal
common_includes += device/motorola/msm8960dt-common/display/libqservice

ifeq ($(TARGET_USES_POST_PROCESSING),true)
    common_flags     += -DUSES_POST_PROCESSING
    common_includes += $(TARGET_OUT_HEADERS)/pp/inc
endif


#Common libraries external to display HAL
common_libs := liblog libutils libcutils libhardware

#Common C flags
common_flags := -DDEBUG_CALC_FPS -Wno-missing-field-initializers
# TEMP HACK: removing -Werror here as it floats into other code (namely audio-caf/libalsa-intf) and breaks the build 
#common_flags += -Werror

ifeq ($(ARCH_ARM_HAVE_NEON),true)
    common_flags += -D__ARM_HAVE_NEON
endif

ifeq ($(TARGET_BOARD_PLATFORM), msm8974)
    common_flags += -DVENUS_COLOR_FORMAT
    common_flags += -DMDSS_TARGET
endif

common_deps  :=
kernel_includes :=


# Executed only on QCOM BSPs
ifeq ($(TARGET_USES_QCOM_BSP),true)
# This flag is used to compile out any features that depend on framework changes
    common_flags += -DQCOM_BSP
endif

ifeq ($(call is-vendor-board-platform,QCOM),true)
    common_deps += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr
    kernel_includes += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
endif
