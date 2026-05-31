#!/usr/bin/env bash
set -euo pipefail

APP_NAME="Tinycord"
BINARY="tinycord"
VERSION="${GORELEASER_CURRENT_TAG:-$(git describe --tags --abbrev=0 2>/dev/null || echo "0.1.0")}"
VERSION="${VERSION#v}"
UNIVERSAL_DIR="dist/tinycord_darwin_universal"
BUNDLE_DIR="dist/${APP_NAME}.app"
DMG_NAME="dist/${APP_NAME}_${VERSION}_universal.dmg"

if [ ! -f "${UNIVERSAL_DIR}/${BINARY}" ]; then
    echo "Error: Universal binary not found at ${UNIVERSAL_DIR}/${BINARY}"
    exit 1
fi

rm -rf "${BUNDLE_DIR}"
mkdir -p "${BUNDLE_DIR}/Contents/MacOS"
mkdir -p "${BUNDLE_DIR}/Contents/Resources"

cp "${UNIVERSAL_DIR}/${BINARY}" "${BUNDLE_DIR}/Contents/MacOS/${BINARY}"

if [ -f "apps/desktop/assets/icon.icns" ]; then
    cp "apps/desktop/assets/icon.icns" "${BUNDLE_DIR}/Contents/Resources/icon.icns"
fi

cat > "${BUNDLE_DIR}/Contents/Info.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleDevelopmentRegion</key>
    <string>en</string>
    <key>CFBundleExecutable</key>
    <string>${BINARY}</string>
    <key>CFBundleIdentifier</key>
    <string>me.hdzilyes.tinycord</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleName</key>
    <string>${APP_NAME}</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>${VERSION}</string>
    <key>CFBundleVersion</key>
    <string>${VERSION}</string>
    <key>LSMinimumSystemVersion</key>
    <string>12.0</string>
    <key>NSHighResolutionCapable</key>
    <true/>
    <key>CFBundleIconFile</key>
    <string>icon.icns</string>
    <key>NSMicrophoneUsageDescription</key>
    <string>Tinycord needs microphone access for voice calls.</string>
    <key>NSCameraUsageDescription</key>
    <string>Tinycord needs camera access for video calls.</string>
</dict>
</plist>
EOF

if [ -f "apps/desktop/assets/entitlements.plist" ]; then
    codesign --force --sign - --entitlements apps/desktop/assets/entitlements.plist "${BUNDLE_DIR}" 2>/dev/null || true
fi

hdiutil create \
    -volname "${APP_NAME} ${VERSION}" \
    -srcfolder "${BUNDLE_DIR}" \
    -ov -format UDZO \
    "${DMG_NAME}"

echo "Created ${DMG_NAME}"
du -sh "${DMG_NAME}"

rm -rf "${BUNDLE_DIR}"
