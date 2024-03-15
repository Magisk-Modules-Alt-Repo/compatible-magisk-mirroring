#!/system/bin/sh
#
# Version: 1.0.0
#     by zyhk
#
# Usage: Put this into "/data/adb/post-fs-data.d" and "chmod +x this" there, if your Magisk variant isn't compatible with official Magisk w.r.t mirroring
#

if [ -n "$KSU" ]; then
    MAGISK_FOR_KSU="/data/adb/ksu/bin/ksu-magisk"
    
    if [ -e "$MAGISK_FOR_KSU" ]; then
        # Delete old one, then update it for reflexcting an updated script
        rm -f "$MAGISK_FOR_KSU"
    fi
    
    cat << 'EOF'  > "$MAGISK_FOR_KSU"
#!/system/bin/sh

for a in "$@" ; do
    case "$a" in
        "--path" )
            echo "/mnt/.cmr"
            exit 0
            ;;
        * )
            ;;
    esac
done

exec su "$@"
EOF
    chcon u:object_r:adb_data_file:s0 "$MAGISK_FOR_KSU"
    chown root:root "$MAGISK_FOR_KSU"
    chmod 755 "$MAGISK_FOR_KSU"
    
    MagiskMirror="/mnt/.cmr/.magisk/mirror"
    mkdir -p "$MagiskMirror"
    chown -R root:root "${MagiskMirror}/../.."
    chmod -R a+rx "${MagiskMirror}/../.."
    chcon -R u:object_r:tmpfs:s0 "${MagiskMirror}/../.."
    
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
        fi
    fi
done

exit 0
