#!/bin/bash

# Update script for flake-based NixOS configuration
# This script rebuilds the system using the flake configuration
# Usage: ./update.sh [hostname]
# If no hostname is provided, defaults to 'nixos'

set -e

# Get hostname from argument - required
if [ -z "$1" ]; then
    echo -e "${RED}Error: Hostname is required${NC}"
    echo "Usage: $0 <hostname>"
    echo "Available hosts: yoga, desktop"
    exit 1
fi
HOSTNAME=$1

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Updating NixOS configuration using flake...${NC}"

# Check if we're in the correct directory
if [ ! -f "flake.nix" ]; then
    echo -e "${RED}Error: flake.nix not found in current directory${NC}"
    echo "Please run this script from the nixos-config directory"
    exit 1
fi

# Note: hardware-configuration.nix should be generated once per host and committed
# No need to copy it on every update as it's host-specific and rarely changes

# Add any unstaged changes to git (flakes require files to be tracked)
echo -e "${YELLOW}Adding changes to git...${NC}"
git add .

# Update flake lock file
echo -e "${YELLOW}Updating flake inputs...${NC}"
nix flake update

# Build and switch to new configuration
echo -e "${YELLOW}Building and switching to new configuration for ${HOSTNAME}...${NC}"
sudo nixos-rebuild switch --flake .#${HOSTNAME}

echo -e "${GREEN}Update completed successfully!${NC}"
