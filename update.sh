#!/bin/bash

# Update script for flake-based NixOS configuration
# This script rebuilds the system using the flake configuration

set -e

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

# Copy hardware-configuration.nix from system to local directory
echo -e "${YELLOW}Copying hardware-configuration.nix from /etc/nixos/...${NC}"
sudo cp /etc/nixos/hardware-configuration.nix ./hardware-configuration.nix

# Add any unstaged changes to git (flakes require files to be tracked)
echo -e "${YELLOW}Adding changes to git...${NC}"
git add .

# Update flake lock file
echo -e "${YELLOW}Updating flake inputs...${NC}"
nix flake update

# Build and switch to new configuration
echo -e "${YELLOW}Building and switching to new configuration...${NC}"
sudo nixos-rebuild switch --flake .#nixos

echo -e "${GREEN}✓ System updated successfully!${NC}"
echo -e "${YELLOW}Note: Home Manager changes will be applied on next login or you can run:${NC}"
echo -e "${YELLOW}home-manager switch --flake .#trbiv@nixos${NC}"