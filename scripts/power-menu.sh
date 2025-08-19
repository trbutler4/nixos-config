#!/usr/bin/env bash

# Power menu script for Waybar and Wofi launcher
# Provides options to lock, logout, or shutdown

options="🔒 Lock\n🚪 Logout\n⏻ Shutdown\n❌ Cancel"

chosen=$(echo -e "$options" | wofi --dmenu \
    --prompt "Power Options:" \
    --width 300 \
    --height 200 \
    --location center \
    --allow-markup \
    --insensitive \
    --hide-scroll)

case "$chosen" in
    "🔒 Lock")
        # Use swaylock with better error handling and basic styling
        swaylock --color 1e1e2e --indicator-radius 100 --indicator-thickness 7 --ring-color 313244 --inside-color 1e1e2e --line-color 00000000 --key-hl-color 89b4fa --text-color cdd6f4 --ring-ver-color 89b4fa --inside-ver-color 1e1e2e --ring-wrong-color f38ba8 --inside-wrong-color 1e1e2e 2>/dev/null || {
            # Fallback to basic swaylock if styling fails
            swaylock --color 000000 2>/dev/null || {
                # Final fallback using loginctl if swaylock fails completely
                loginctl lock-session 2>/dev/null || {
                    notify-send "Lock Failed" "Unable to lock screen" 2>/dev/null
                }
            }
        }
        ;;
    "🚪 Logout")
        hyprctl dispatch exit
        ;;
    "⏻ Shutdown")
        systemctl poweroff
        ;;
    "❌ Cancel")
        exit 0
        ;;
    *)
        exit 0
        ;;
esac