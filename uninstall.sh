#!/system/bin/sh

MAGISK_FOR_KSU="/data/adb/ksu/bin/ksu-magisk"
MountingMirrorsScript="mounting-compatible-magisk-mirrors.sh"
TargetDir="/data/adb/post-fs-data.d"

if [ -n "$KSU"  -a  -e "$MAGISK_FOR_KSU" ]; then
    rm -f "$MAGISK_FOR_KSU"
fi

if [ -e "${TargetDir}/${MountingMirrorsScript}" ]; then
    rm -f "${TargetDir}/${MountingMirrorsScript}"
fi
