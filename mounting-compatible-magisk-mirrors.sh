#!/system/bin/sh
#
# Version: 1.0.0
#     by zyhk
#
# Usage: Put this into "/data/adb/post-fs-data.d" and "chmod +x this" there, if your Magisk variant isn't compatible with official Magisk w.r.t mirroring
#

if [ -n "$KSU"  -o  -n "$APATCH" ]; then
    if [ -n "$KSU" ]; then
        MAGISK_FOR_KSU="/data/adb/ksu/bin/ksu-magisk"
    else
        MAGISK_FOR_KSU="/data/adb/ap/bin/ksu-magisk"
    fi
    # Select a new folder under "/mnt"
    KSU_MAGISK_PATH="/mnt/.cmr"
    
    if [ -e "$MAGISK_FOR_KSU" ]; then
        # Delete old one, then update it for reflecting an updating script
        rm -f "$MAGISK_FOR_KSU"
    fi
    
    cat << _EOF_  > "$MAGISK_FOR_KSU"
#!/system/bin/sh

for a in "\$@" ; do
    case "\$a" in
        "--path" )
            echo "$KSU_MAGISK_PATH"
            exit 0
            ;;
        * )
            ;;
    esac
done

exit 1
_EOF_
    chcon u:object_r:adb_data_file:s0 "$MAGISK_FOR_KSU"
    chown root:root "$MAGISK_FOR_KSU"
    chmod 755 "$MAGISK_FOR_KSU"
    
    MagiskMirror="${KSU_MAGISK_PATH}/.magisk/mirror"
    mkdir -p "$MagiskMirror"
    for d in "${KSU_MAGISK_PATH}" "${KSU_MAGISK_PATH}/.magisk" "${KSU_MAGISK_PATH}/.magisk/mirror"; do
        chown  root:root "$d"
        chmod a+rx "$d"
        chcon u:object_r:tmpfs:s0 "$d"
    done
    
else
    MagiskMirror="$(magisk --path)/.magisk/mirror"
    
fi

if [ ! -d "$MagiskMirror" ]; then
    exit 1
fi

for md in "/system" "/vendor" "/odm" "/product" "/my_product" ; do
    if [ -d "$md" ]; then
        if [ ! -d "${MagiskMirror}${md}" ]; then
            mkdir "${MagiskMirror}${md}"
            mount -o ro "${md}" "${MagiskMirror}${md}"
            mount --make-rprivate "${MagiskMirror}${md}"
        fi
    fi
done

exit 0
