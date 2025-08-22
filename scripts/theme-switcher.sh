#!/usr/bin/env bash

# Theme switcher script for NixOS configuration
# This script switches themes and rebuilds the system

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$(dirname "$SCRIPT_DIR")"
THEMES_DIR="$CONFIG_DIR/hosts/shared/themes"
THEME_CONFIG="$THEMES_DIR/default.nix"

# Available themes
THEMES=("gruvbox" "everforest")

get_current_theme() {
    if [[ -f "$THEME_CONFIG" ]]; then
        grep 'current = ' "$THEME_CONFIG" | sed 's/.*current = "\([^"]*\)".*/\1/'
    else
        echo "gruvbox"
    fi
}

set_theme() {
    local theme="$1"
    
    # Validate theme
    if [[ ! " ${THEMES[@]} " =~ " ${theme} " ]]; then
        echo "Error: Invalid theme '$theme'. Available themes: ${THEMES[*]}" >&2
        exit 1
    fi
    
    # Update theme configuration
    cat > "$THEME_CONFIG" << EOF
{
  # Import theme modules
  gruvbox = import ./gruvbox.nix;
  everforest = import ./everforest.nix;
  
  # Theme selection - change this to switch themes globally
  current = "$theme";
}
EOF
    
    echo "Theme set to: $theme"
    echo "Note: Run 'sudo nixos-rebuild switch --flake .#yoga' to apply changes"
}

show_current_theme() {
    local current=$(get_current_theme)
    echo "Current theme: $current"
}

interactive_select() {
    local current=$(get_current_theme)
    
    echo "Available themes:"
    for i in "${!THEMES[@]}"; do
        local theme="${THEMES[$i]}"
        local marker=""
        [[ "$theme" == "$current" ]] && marker=" (current)"
        echo "$((i + 1)). $theme$marker"
    done
    
    read -p "Select theme (1-${#THEMES[@]}): " choice
    
    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#THEMES[@]}" ]; then
        local selected_theme="${THEMES[$((choice - 1))]}"
        set_theme "$selected_theme"
    else
        echo "Error: Invalid selection" >&2
        exit 1
    fi
}

wofi_select() {
    local current=$(get_current_theme)
    local options=""
    
    for theme in "${THEMES[@]}"; do
        local marker=""
        [[ "$theme" == "$current" ]] && marker=" (current)"
        options="$options$theme$marker\n"
    done
    
    # Remove trailing newline
    options="${options%\\n}"
    
    local selected=$(echo -e "$options" | wofi --dmenu --prompt "Select Theme:" --width 300 --height 200)
    
    if [[ -n "$selected" ]]; then
        # Remove the " (current)" marker if present
        selected=$(echo "$selected" | sed 's/ (current)$//')
        set_theme "$selected"
        
        # Show notification
        notify-send "Theme Switcher" "Theme changed to: $selected\nRun rebuild to apply changes" --icon=preferences-desktop-theme
    fi
}

show_help() {
    cat << EOF
Theme Switcher for NixOS Configuration

Usage: $0 [COMMAND] [THEME]

Commands:
    current         Show current theme
    set THEME       Set theme to THEME
    list            List available themes
    interactive     Interactive theme selection
    wofi            Wofi-based theme selection (for use with launcher)
    help            Show this help

Available themes: ${THEMES[*]}

Examples:
    $0 current
    $0 set gruvbox
    $0 set everforest
    $0 interactive
    $0 wofi

Note: After changing themes, run 'sudo nixos-rebuild switch --flake .#yoga' to apply changes.
EOF
}

case "${1:-help}" in
    "current")
        show_current_theme
        ;;
    "set")
        if [[ $# -ne 2 ]]; then
            echo "Error: set command requires a theme name" >&2
            echo "Available themes: ${THEMES[*]}" >&2
            exit 1
        fi
        set_theme "$2"
        ;;
    "list")
        echo "Available themes: ${THEMES[*]}"
        show_current_theme
        ;;
    "interactive")
        interactive_select
        ;;
    "wofi")
        wofi_select
        ;;
    "help"|"--help"|"-h")
        show_help
        ;;
    *)
        echo "Error: Unknown command '$1'" >&2
        show_help
        exit 1
        ;;
esac