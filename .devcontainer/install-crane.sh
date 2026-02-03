#!/usr/bin/env bash
# Install crane (Google's container registry tool)
# Runs inside Linux container regardless of host OS (Mac/Windows/Linux)

set -euo pipefail

CRANE_VERSION="${CRANE_VERSION:-latest}"

echo "Installing crane..."

# Container is always Linux - normalize architecture
ARCH="$(uname -m)"
case "${ARCH}" in
    x86_64) CRANE_ARCH="x86_64" ;;
    aarch64|arm64) CRANE_ARCH="arm64" ;;
    *)
        echo "ERROR: Unsupported architecture: ${ARCH}"
        echo "Crane supports: x86_64, arm64/aarch64"
        exit 1
        ;;
esac

# Get latest version if not specified
if [ "${CRANE_VERSION}" = "latest" ]; then
    CRANE_VERSION=$(curl -s https://api.github.com/repos/google/go-containerregistry/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
fi

echo "  Version: ${CRANE_VERSION}"
echo "  Architecture: ${CRANE_ARCH}"

# Download and install
DOWNLOAD_URL="https://github.com/google/go-containerregistry/releases/download/${CRANE_VERSION}/go-containerregistry_Linux_${CRANE_ARCH}.tar.gz"
TMP_DIR=$(mktemp -d)

curl -fsSL "${DOWNLOAD_URL}" | tar -xz -C "${TMP_DIR}" crane
sudo mv "${TMP_DIR}/crane" /usr/local/bin/crane
sudo chmod +x /usr/local/bin/crane
rm -rf "${TMP_DIR}"

# Verify installation
crane version
echo "✓ crane installed successfully"
