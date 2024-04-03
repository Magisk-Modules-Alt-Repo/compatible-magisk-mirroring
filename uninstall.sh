#!/system/bin/sh

MountingMirrorsScript="mounting-compatible-magisk-mirrors.sh"
TargetDir="/data/adb/post-fs-data.d"
if [ -n "$KSU" ]; then
    MAGISK_FOR_KSU="/data/adb/ksu/bin/ksu-magisk"
elif [ -n "$APATCH" ]; then
    MAGISK_FOR_KSU="/data/adb/ap/bin/ksu-magisk"
else
    MAGISK_FOR_KSU=""
fi
# Select a new folder under "/mnt"
KSU_MAGISK_PATH="/mnt/.cmr"

if [ -n "$MAGISK_FOR_KSU"  -a  -e "$MAGISK_FOR_KSU" ]; then
    rm -f "$MAGISK_FOR_KSU"
    MagiskMirror="${KSU_MAGISK_PATH}/.magisk/mirror"
else
    MagiskMirror="$(magisk --path)/.magisk/mirror"
fi

if [ -e "${TargetDir}/${MountingMirrorsScript}" ]; then
    rm -f "${TargetDir}/${MountingMirrorsScript}"
    if [ -z $(ls -A "${TargetDir}") ]; then
        # KernelSU and APatch don't have this folder by default
        rmdir "${TargetDir}"
    fi
fi

# Umount mirrors which have been mounted by "${TargetDir}/${MountingMirrorsScript}" (global post-fs-data.d) just before deleting this module files
if [ -n "$MagiskMirror"  -a  -d "$MagiskMirror" ]; then
    for md in "/system" "/vendor" "/odm" "/product" "/my_product" ; do
        if [ -d "${MagiskMirror}${md}" ]; then
            umount "${MagiskMirror}${md}"
            rmdir "${MagiskMirror}${md}"
        fi
    done
fi

if [ -n "$MAGISK_FOR_KSU"  -a  "${KSU_MAGISK_PATH%/*}" = "/mnt" ]; then
    rmdir "${KSU_MAGISK_PATH}/.magisk/mirror"
    rmdir "${KSU_MAGISK_PATH}/.magisk"
    rmdir "${KSU_MAGISK_PATH}"
fi
