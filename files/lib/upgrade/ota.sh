. /lib/functions.sh
. /lib/functions/system.sh

export_ota_url() {
    local board

    board="$(board_name 2>/dev/null)"
    case "$board" in
        friendlyarm,nanopi-r6c)
            OTA_URL_BASE="https://github.com/nanptr/openwrt-build/releases/latest/download"
            OTA_RELEASES_URL="https://github.com/nanptr/openwrt-build/releases"
            export OTA_URL_BASE OTA_RELEASES_URL
            return 0
        ;;
    esac

    return 1
}
