#!/usr/bin/env bash

# Wallpaper switching script for hyprpaper
# Cycles through wallpapers in the specified directory

WALLPAPER_DIR="/home/trbiv/nixos-config/assets/wallpapers"
STATE_FILE="/tmp/wallpaper_current"
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

# Set wallpaper for all monitors
set_wallpaper() {
    local wallpaper="$1"
    
    # Preload the wallpaper if not already loaded
    hyprctl hyprpaper preload "$wallpaper" 2>/dev/null
    
    # Set wallpaper on all monitors
    hyprctl monitors -j | jq -r '.[].name' | while read -r monitor; do
        hyprctl hyprpaper wallpaper "$monitor,$wallpaper" 2>/dev/null
    done
}

# Get wallpaper name for display
get_wallpaper_name() {
    local wallpaper="$1"
    basename "$wallpaper" | sed 's/\.[^.]*$//'
}

# Main function
main() {
    local action="$1"
    local wallpapers
    wallpapers=($(get_wallpapers))
    
    if [[ ${#wallpapers[@]} -eq 0 ]]; then
        echo "No wallpapers found in $WALLPAPER_DIR"
        exit 1
    fi
    
    local current_index
    current_index=$(get_current_index)
    
    case "$action" in
        "next")
            current_index=$(( (current_index + 1) % ${#wallpapers[@]} ))
            ;;
        "prev")
            current_index=$(( (current_index - 1 + ${#wallpapers[@]}) % ${#wallpapers[@]} ))
            ;;
        "random")
            current_index=$((RANDOM % ${#wallpapers[@]}))
            ;;
        "current")
            if [[ $current_index -lt ${#wallpapers[@]} ]]; then
                get_wallpaper_name "${wallpapers[$current_index]}"
            else
                echo "Unknown"
            fi
            exit 0
            ;;
        "list")
            for i in "${!wallpapers[@]}"; do
                local marker=""
                [[ $i -eq $current_index ]] && marker=" *"
                echo "$i: $(get_wallpaper_name "${wallpapers[$i]}")$marker"
            done
            exit 0
            ;;
        *)
            echo "Usage: $0 {next|prev|random|current|list}"
            exit 1
            ;;
    esac
    
    # Save current index
    echo "$current_index" > "$STATE_FILE"
    
    # Set the wallpaper
    set_wallpaper "${wallpapers[$current_index]}"
    
    # Output current wallpaper name for waybar
    get_wallpaper_name "${wallpapers[$current_index]}"
}

main "$@"