#!/usr/bin/env bash
set -euo pipefail

VERSION="${GORELEASER_CURRENT_TAG:-$(git describe --tags --abbrev=0 2>/dev/null || echo "0.1.0")}"
VERSION="${VERSION#v}"
ARCH_DIR="${PWD}/dist/tinycord_windows_amd64_v1"

if [ ! -f "${ARCH_DIR}/tinycord.exe" ]; then
    echo "Warning: Windows binary not found at ${ARCH_DIR}/tinycord.exe"
    exit 0
fi

if ! command -v makensis &>/dev/null; then
    echo "Error: makensis not found. Install with: brew install makensis"
    exit 1
fi

NSIS_SCRIPT=$(mktemp -t tinycord-installer-XXXXXX).nsi
trap 'rm -f "${NSIS_SCRIPT}"' EXIT

BINARY_PATH="${ARCH_DIR}/tinycord.exe"
OUT_PATH="${PWD}/dist/Tinycord-${VERSION}-Setup.exe"

cat > "${NSIS_SCRIPT}" <<EOF
!define PRODUCT_NAME "Tinycord"
!define PRODUCT_VERSION "${VERSION}"
!define PRODUCT_PUBLISHER "Tinycord"
!define PRODUCT_WEB_SITE "https://tinycord.app"

Name "\${PRODUCT_NAME} \${PRODUCT_VERSION}"
OutFile "${OUT_PATH}"
InstallDir "\$PROGRAMFILES64\\\${PRODUCT_NAME}"
RequestExecutionLevel admin

Section "Install"
  SetOutPath "\$INSTDIR"
  File "${BINARY_PATH}"

  CreateDirectory "\$SMPROGRAMS\\\${PRODUCT_NAME}"
  CreateShortCut "\$SMPROGRAMS\\\${PRODUCT_NAME}\\\${PRODUCT_NAME}.lnk" "\$INSTDIR\\tinycord.exe"
  CreateShortCut "\$DESKTOP\\\${PRODUCT_NAME}.lnk" "\$INSTDIR\\tinycord.exe"
SectionEnd

Section "Uninstall"
  RMDir /r "\$INSTDIR"
  Delete "\$SMPROGRAMS\\\${PRODUCT_NAME}\\\${PRODUCT_NAME}.lnk"
  Delete "\$DESKTOP\\\${PRODUCT_NAME}.lnk"
  RMDir "\$SMPROGRAMS\\\${PRODUCT_NAME}"
SectionEnd
EOF

makensis "${NSIS_SCRIPT}"

echo "Created Windows installer"
ls -lh "${OUT_PATH}"
