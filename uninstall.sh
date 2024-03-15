#!/system/bin/sh

MAGISK_FOR_KSU="/data/adb/ksu/bin/ksu-magisk"
MountingMirrorsScript="mounting-compatible-magisk-mirrors.sh"
TargetDir="/data/adb/post-fs-data.d"

if [ -n "$KSU"  -a  -e "$MAGISK_FOR_KSU" ]; then
    rm -f "$MAGISK_FOR_KSU"
    MagiskMirror="/mnt/.cmr/.magisk/mirror"
else
    MagiskMirror="$(magisk --path)/.magisk/mirror"
fi

if [ -e "${TargetDir}/${MountingMirrorsScript}" ]; then
    rm -f "${TargetDir}/${MountingMirrorsScript}"
fi

# Umount mirrors which has been mounted by "${TargetDir}/${MountingMirrorsScript}" before deleting
if [ -d "$MagiskMirror" ]; then
    for md in "/system" "/vendor" "/odm" "/product" "/my_product" ; do
        if [ -d "${MagiskMirror}${md}" ]; then
            umount "${MagiskMirror}${md}"
            rmdir "${MagiskMirror}${md}"
        fi
    done
fi
if [ -n "$KSU" ]; then
    rm -R -f "${MagiskMirror}/../.."
fi
