#!/system/bin/sh

MountingMirrorsScript="mounting-compatible-magisk-mirrors.sh"
TargetDir="/data/adb/post-fs-data.d"
MAGISK_FOR_KSU="/data/adb/ksu/bin/ksu-magisk"
# Select a new folder under "/mnt"
KSU_MAGISK_PATH="/mnt/.cmr"

if [ -n "$KSU"  -a  -e "$MAGISK_FOR_KSU" ]; then
    rm -f "$MAGISK_FOR_KSU"
    MagiskMirror="${KSU_MAGISK_PATH}/.magisk/mirror"
else
    MagiskMirror="$(magisk --path)/.magisk/mirror"
fi

if [ -e "${TargetDir}/${MountingMirrorsScript}" ]; then
    rm -f "${TargetDir}/${MountingMirrorsScript}"
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

if [ -n "$KSU"  -a  "${KSU_MAGISK_PATH%/*}" = "/mnt" ]; then
    rmdir "${KSU_MAGISK_PATH}/.magisk/mirror"
    rmdir "${KSU_MAGISK_PATH}/.magisk"
    rmdir "${KSU_MAGISK_PATH}"
fi
