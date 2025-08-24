#!/usr/bin/env bash

# Script to switch themes for NixOS configuration
# Usage: ./switch-theme.sh [gruvbox|everforest]

set -e

THEME_FILE="hosts/shared/themes/default.nix"
CURRENT_DIR=$(dirname "$0")
CONFIG_DIR=$(realpath "$CURRENT_DIR/..")

if [ $# -ne 1 ]; then
    echo "Usage: $0 [gruvbox|everforest]"
    echo "Current theme: $(grep 'current = ' "$CONFIG_DIR/$THEME_FILE" | cut -d'"' -f2)"
    exit 1
fi

THEME=$1

if [ "$THEME" != "gruvbox" ] && [ "$THEME" != "everforest" ]; then
    echo "Error: Theme must be either 'gruvbox' or 'everforest'"
    exit 1
fi

cd "$CONFIG_DIR"

# Update the theme file
sed -i "s/current = \".*\"/current = \"$THEME\"/" "$THEME_FILE"

echo "Theme switched to: $THEME"
echo "Run 'sudo nixos-rebuild switch --flake .#yoga' to apply changes"