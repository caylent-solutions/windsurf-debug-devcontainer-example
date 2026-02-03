#!/usr/bin/env bash

# Project-specific setup script
# This script runs after the main devcontainer setup is complete
# Add your project-specific initialization commands here
#
# Examples:
# - make configure
# - npm install
# - pip install -r requirements.txt
# - docker-compose up -d
# - Initialize databases
# - Download project dependencies
# - Run project-specific configuration

set -euo pipefail

# Source shared functions
source "$(dirname "$0")/devcontainer-functions.sh"

log_info "Running project-specific setup..."

# Install crane
log_info "Installing crane..."
bash "$(dirname "$0")/install-crane.sh"

# Install Snyk CLI
log_info "Installing Snyk CLI..."
bash "$(dirname "$0")/install-snyk.sh"

# Configure Claude Code for AWS Bedrock
log_info "Configuring Claude Code for AWS Bedrock..."
mkdir -p /home/vscode/.claude

# Validate required environment variables
if [ -z "${AWS_REGION:-}" ]; then
  log_error "AWS_REGION environment variable is not set"
  log_error "This is required for Claude Code Bedrock configuration"
  exit 1
fi

if [ -z "${AWS_PROFILE:-}" ]; then
  log_error "AWS_PROFILE environment variable is not set"
  log_error "This is required for Claude Code Bedrock configuration"
  exit 1
fi

if [ -z "${CLAUDE_CODE_USE_BEDROCK:-}" ]; then
  log_error "CLAUDE_CODE_USE_BEDROCK environment variable is not set"
  log_error "This should be set to '1' in devcontainer.json containerEnv"
  exit 1
fi

cat > /home/vscode/.claude/settings.json << EOF
{
  "awsAuthRefresh": "aws sso login --profile ${AWS_PROFILE}",
  "env": {
    "AWS_PROFILE": "${AWS_PROFILE}",
    "AWS_REGION": "${AWS_REGION}",
    "CLAUDE_CODE_USE_BEDROCK": "1"
  }
}
EOF

chown -R vscode:vscode /home/vscode/.claude
log_success "Claude Code configured for AWS Bedrock with profile: ${AWS_PROFILE}, region: ${AWS_REGION}"



log_info "Project-specific setup complete"

echo ""
log_success "=============================================="
log_success "  Devcontainer Setup Complete!"
log_success "=============================================="
echo ""
echo "Next steps:"
echo ""
echo "  1. Authenticate with AWS SSO:"
echo "     aws sso login --profile ${AWS_PROFILE}"
echo ""
