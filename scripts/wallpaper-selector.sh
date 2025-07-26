#!/usr/bin/env bash

# Wallpaper selection menu using wofi
# Shows all available wallpapers for selection
# Handles single instance and toggle behavior

WALLPAPER_DIR="/home/trbiv/nixos-config/assets/wallpapers"
STATE_FILE="/tmp/wallpaper_current"
LOCK_FILE="/tmp/wallpaper_selector.lock"
WOFI_PID_FILE="/tmp/wallpaper_selector_wofi.pid"
SUPPORTED_FORMATS="jpg|jpeg|png|webp|jxl"

# Get all wallpaper files
get_wallpapers() {
    find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.jxl" \) | sort
}

# Get current wallpaper index
get_current_index() {
    if [[ -f "$STATE_FILE" ]]; then
        cat "$STATE_FILE"
    else
        echo "0"
    fi
}

# Get wallpaper name for display
get_wallpaper_name() {
    local wallpaper="$1"
    basename "$wallpaper" | sed 's/\.[^.]*$//'
}

# Set wallpaper for all monitors
set_wallpaper() {
    local wallpaper="$1"
    
    # Preload the wallpaper if not already loaded
    hyprctl hyprpaper preload "$wallpaper" 2>/dev/null
    
    # Set wallpaper on all monitors
    hyprctl monitors -j | jq -r '.[].name' | while read -r monitor; do
        hyprctl hyprpaper wallpaper "$monitor,$wallpaper" 2>/dev/null
    done
    
    # Also set with empty monitor name as fallback (for default monitor)
    hyprctl hyprpaper wallpaper ",$wallpaper" 2>/dev/null
}

# Check if selector is already running and kill it
cleanup_existing() {
    # Kill any existing wofi wallpaper selector
    if [[ -f "$WOFI_PID_FILE" ]]; then
        local pid=$(cat "$WOFI_PID_FILE")
        if kill -0 "$pid" 2>/dev/null; then
            kill "$pid" 2>/dev/null
            rm -f "$WOFI_PID_FILE"
            rm -f "$LOCK_FILE"
            exit 0  # Exit after closing existing instance (toggle behavior)
        fi
        rm -f "$WOFI_PID_FILE"
    fi
    
    # Also kill any wofi process that might be running with our prompt
    pkill -f "wofi.*Select Wallpaper" 2>/dev/null
}

# Cleanup function for script exit
cleanup() {
    rm -f "$LOCK_FILE" "$WOFI_PID_FILE"
}

# Set trap for cleanup
trap cleanup EXIT

# Main function
main() {
    # Check for existing instance and handle toggle behavior
    cleanup_existing
    
    # Create lock file
    echo $$ > "$LOCK_FILE"
    
    local wallpapers
    wallpapers=($(get_wallpapers))
    
    if [[ ${#wallpapers[@]} -eq 0 ]]; then
        notify-send "Wallpaper Selector" "No wallpapers found in $WALLPAPER_DIR"
        exit 1
    fi
    
    local current_index
    current_index=$(get_current_index)
    
    # Create menu options with current wallpaper marked
    local menu_options=""
    for i in "${!wallpapers[@]}"; do
        local name=$(get_wallpaper_name "${wallpapers[$i]}")
        local marker=""
        [[ $i -eq $current_index ]] && marker=" ✓"
        menu_options+="$name$marker\n"
    done
    
    # Show wofi selection menu and capture result
    local selected_name
    selected_name=$(echo -e "$menu_options" | wofi --dmenu --prompt "Select Wallpaper:" --lines 10 --width 400 --height 300)
    
    # Exit if no selection made
    [[ -z "$selected_name" ]] && exit 0
    
    # Remove the checkmark if present
    selected_name=$(echo "$selected_name" | sed 's/ ✓$//')
    
    # Find the corresponding wallpaper file
    local selected_index=-1
    for i in "${!wallpapers[@]}"; do
        local name=$(get_wallpaper_name "${wallpapers[$i]}")
        if [[ "$name" == "$selected_name" ]]; then
            selected_index=$i
            break
        fi
    done
    
    # Exit if wallpaper not found
    if [[ $selected_index -eq -1 ]]; then
        notify-send "Wallpaper Selector" "Selected wallpaper not found"
        exit 1
    fi
    
    # Save selected index
    echo "$selected_index" > "$STATE_FILE"
    
    # Set the wallpaper
    set_wallpaper "${wallpapers[$selected_index]}"
    
    # Update waybar
    pkill -SIGRTMIN+8 waybar
    
    # Notify user
    notify-send "Wallpaper Changed" "Set to: $selected_name"
}

main "$@"