#!/system/bin/sh

MountingMirrorsScript="mounting-compatible-magisk-mirrors.sh"
TargetDir="/data/adb/post-fs-data.d"

function isCompatibleMagiskMirroring()
{
    local tmp="$(magisk --path)"
    if [ -z "$tmp" ]; then
        return 1
    elif [ -d "${tmp}/.magisk/mirror/vendor" ]; then
        return 0
    else
        return 1
    fi
}

if ! isCompatibleMagiskMirroring || [ -e "${TargetDir}/${MountingMirrorsScript}" ]; then
    if [ ! -d "${TargetDir}" ]; then
        # KernelSU and APatch don't have this folder by default
        mkdir "${TargetDir}"
        chcon u:object_r:adb_data_file:s0 "${TargetDir}"
        chown root:root "${TargetDir}"
        chmod 755 "${TargetDir}"
    fi
    cp -f "${MODPATH}/${MountingMirrorsScript}" "${TargetDir}/${MountingMirrorsScript}"
    chcon u:object_r:adb_data_file:s0 "${TargetDir}/${MountingMirrorsScript}"
    chown root:root "${TargetDir}/${MountingMirrorsScript}"
    chmod 755 "${TargetDir}/${MountingMirrorsScript}"
else
    abort "  ***  Aborted: found the compatible Magisk-mirroring! ***"
fi

rm -f "${MODPATH}/${MountingMirrorsScript}" "${MODPATH}/LICENSE" "${MODPATH}/README.md" "${MODPATH}/changelog.md"
