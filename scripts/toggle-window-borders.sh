#!/usr/bin/env bash

# Toggle window borders on/off
# Stores state in a temp file to remember current setting

STATE_FILE="/tmp/hyprland_borders_state"

# Check current border state
get_current_border_size() {
    hyprctl getoption general:border_size | grep -oP 'int: \K\d+'
}

# Toggle border state
toggle_borders() {
    local current_size=$(get_current_border_size)
    
    if [[ "$current_size" == "0" ]]; then
        # Borders are off, turn them on
        hyprctl keyword general:border_size 2
        echo "enabled" > "$STATE_FILE"
        notify-send "Window Borders" "Enabled" --icon=preferences-system-windows
    else
        # Borders are on, turn them off  
        hyprctl keyword general:border_size 0
        echo "disabled" > "$STATE_FILE"
        notify-send "Window Borders" "Disabled" --icon=preferences-system-windows
    fi
}

# Main execution
case "${1:-toggle}" in
    "on"|"enable")
        hyprctl keyword general:border_size 2
        echo "enabled" > "$STATE_FILE"
        notify-send "Window Borders" "Enabled" --icon=preferences-system-windows
        ;;
    "off"|"disable")
        hyprctl keyword general:border_size 0
        echo "disabled" > "$STATE_FILE"
        notify-send "Window Borders" "Disabled" --icon=preferences-system-windows
        ;;
    "toggle"|*)
        toggle_borders
        ;;
esac