#!/usr/bin/env bash

# Interactive Screenshot Utility for Hyprland
# Provides a menu-driven interface for taking screenshots

SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
TIMESTAMP=$(date +'%Y%m%d_%H%M%S')

# Ensure screenshot directory exists
mkdir -p "$SCREENSHOT_DIR"

# Menu options
OPTIONS="Fullscreen\nArea Selection\nActive Window\nDelay 3s Fullscreen\nDelay 5s Fullscreen"

# Show menu using wofi
CHOICE=$(echo -e "$OPTIONS" | wofi --dmenu --prompt "Screenshot:" --height 200 --width 300)

case "$CHOICE" in
    "Fullscreen")
        grim "$SCREENSHOT_DIR/screenshot_$TIMESTAMP.png"
        notify-send "Screenshot" "Fullscreen captured: screenshot_$TIMESTAMP.png"
        ;;
    "Area Selection")
        grim -g "$(slurp)" "$SCREENSHOT_DIR/screenshot_$TIMESTAMP.png"
        notify-send "Screenshot" "Area captured: screenshot_$TIMESTAMP.png"
        ;;
    "Active Window")
        # Get active window geometry
        WINDOW_GEOM=$(hyprctl activewindow -j | jq -r '.at,.size | tostring' | sed 'N;s/\n/ /' | sed 's/\[//g;s/\]//g;s/,/ /g')
        grim -g "$WINDOW_GEOM" "$SCREENSHOT_DIR/screenshot_$TIMESTAMP.png"
        notify-send "Screenshot" "Window captured: screenshot_$TIMESTAMP.png"
        ;;
    "Delay 3s Fullscreen")
        notify-send "Screenshot" "Taking fullscreen in 3 seconds..."
        sleep 3
        grim "$SCREENSHOT_DIR/screenshot_$TIMESTAMP.png"
        notify-send "Screenshot" "Delayed fullscreen captured: screenshot_$TIMESTAMP.png"
        ;;
    "Delay 5s Fullscreen")
        notify-send "Screenshot" "Taking fullscreen in 5 seconds..."
        sleep 5
        grim "$SCREENSHOT_DIR/screenshot_$TIMESTAMP.png"
        notify-send "Screenshot" "Delayed fullscreen captured: screenshot_$TIMESTAMP.png"
        ;;
    *)
        # User cancelled or invalid choice
        exit 0
        ;;
esac