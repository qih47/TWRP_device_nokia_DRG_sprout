#
# Copyright 2018 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Release name
PRODUCT_RELEASE_NAME := DRG_sprout

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

$(call inherit-product, $(SRC_TARGET_DIR)/product/embedded.mk)

# Inherit from our custom product configuration
$(call inherit-product, vendor/pb/config/common.mk)

# A/B updater
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    system \
    vendor \
    dtbo

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

PRODUCT_PACKAGES += \
    otapreopt_script \
    update_engine \
    update_verifier
    # update_engine_sideload \

# The following modules are included in debuggable builds only.
PRODUCT_PACKAGES_DEBUG += \
    bootctl \
    update_engine_client

# Boot control HAL
PRODUCT_PACKAGES += \
    bootctrl.sdm660

PRODUCT_STATIC_BOOT_CONTROL_HAL := \
    bootctrl.sdm660 \
    libcutils \
    libgptutils \
    libz

PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe \
    tzdata_twrp

	# Partitions (listed in the file) to be wiped under recovery.
TARGET_RECOVERY_WIPE := \
    device/nokia/DRG_sprout/recovery/root/etc/recovery.wipe	

# add support for future ota updates
PRODUCT_PROPERTY_OVERRIDES += \
    ro.secure=0 \
    ro.adb.secure=0 \
    ro.allow.mock.location=0 \
    ro.hardware.keystore=sdm660

## Device identifier. This must come after all inclusions
PRODUCT_NAME := omni_DRG_sprout
PRODUCT_DEVICE := DRG_sprout
PRODUCT_MANUFACTURER := FIH
PRODUCT_BRAND := Nokia
PRODUCT_MODEL := Nokia 6.1 Plus

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="Dragon_00WW 10 QKQ1.190828.002 00WW_4_15C release-keys"

BUILD_FINGERPRINT := Nokia/Dragon_00WW/DRG_sprout:10/QKQ1.190828.002/00WW_4_15C:user/release-keys
