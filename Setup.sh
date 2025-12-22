#!/bin/bash
### ===== CẤU HÌNH =====
LOA_IP="192.168.43.1"
ADB_DEVICE="$LOA_IP:5555"

APK1="AuToDLNA.apk"
APK2="Unisound.apk"

APK1_URL="https://github.com/trunghieu1604/r1-ai/releases/download/v1.0/AutoDLNA.apk"
APK2_URL="https://github.com/trunghieu1604/r1-ai/releases/download/v1.0/Unisound.apk"

### ===== KIỂM TRA ADB (iSH) =====
if ! command -v adb >/dev/null 2>&1; then
    echo "[INFO] Dang cai adb..."
    apk add --no-cache android-tools || exit 1
fi

### ===== HÀM ĐỢI WIFI =====
wait_for_wifi() {
    echo "[INFO] Hay ket noi Wi-Fi cua loa Phicomm R1..."
    while true; do
        if ping -c 1 -W 1 "$LOA_IP" >/dev/null 2>&1; then
            echo "[INFO] Da ket noi Wi-Fi."
            return
        fi
        sleep 3
    done
}

### ===== TẢI APK =====
[ ! -f "$APK1" ] && wget -O "$APK1" "$APK1_URL"
[ ! -f "$APK2" ] && wget -O "$APK2" "$APK2_URL"

### ===== ĐỢI WIFI → KẾT NỐI ADB =====
wait_for_wifi
adb connect "$ADB_DEVICE"

### ===== CÀI APK (GIỐNG BAT) =====
adb install -r "$APK1" || exit 1
adb install -r "$APK2" || exit 1

echo "✅ Hoan tat cai dat"
