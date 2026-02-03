#!/usr/bin/env bash
# Install Snyk CLI
# Runs inside Linux container regardless of host OS (Mac/Windows/Linux)

set -euo pipefail

echo "Installing Snyk CLI..."

# Container is always Linux - normalize architecture
ARCH="$(uname -m)"
case "${ARCH}" in
    x86_64) SNYK_BINARY="snyk-linux" ;;
    aarch64|arm64) SNYK_BINARY="snyk-linux-arm64" ;;
    *)
        echo "ERROR: Unsupported architecture: ${ARCH}"
        exit 1
        ;;
esac

echo "  Architecture: ${ARCH}"
echo "  Binary: ${SNYK_BINARY}"

# Download and install
curl -fsSL "https://static.snyk.io/cli/latest/${SNYK_BINARY}" -o /tmp/snyk
sudo mv /tmp/snyk /usr/local/bin/snyk
sudo chmod +x /usr/local/bin/snyk

# Verify installation
snyk --version
echo "✓ Snyk CLI installed successfully"
