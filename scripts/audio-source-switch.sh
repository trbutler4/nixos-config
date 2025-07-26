#!/usr/bin/env bash

# Script to cycle through available audio sources (microphones/input devices)
# Uses wpctl (WirePlumber control utility) which is part of PipeWire

# Get list of available audio sources
sources=$(wpctl status | grep -A 50 "Audio/Sources:" | grep -E "^\s*│\s*[0-9]+\." | grep -v "Monitor of" | head -10)

if [[ -z "$sources" ]]; then
    notify-send "Audio Sources" "No audio sources found" -t 2000
    exit 1
fi

# Get current default source
current_source=$(wpctl status | grep -A 50 "Audio/Sources:" | grep -E "^\s*├─.*\*" | head -1)
current_id=$(echo "$current_source" | grep -o '[0-9]\+' | head -1)

# Parse available sources into arrays
declare -a source_ids
declare -a source_names

while IFS= read -r line; do
    if [[ -n "$line" ]]; then
        id=$(echo "$line" | grep -o '[0-9]\+' | head -1)
        name=$(echo "$line" | sed 's/.*[0-9]\+\.\s*//' | sed 's/\[.*\]//')
        source_ids+=("$id")
        source_names+=("$name")
    fi
done <<< "$sources"

# Find current source index
current_index=-1
for i in "${!source_ids[@]}"; do
    if [[ "${source_ids[$i]}" == "$current_id" ]]; then
        current_index=$i
        break
    fi
done

# Calculate next source index (cycle)
if [[ $current_index -eq -1 ]] || [[ $current_index -eq $((${#source_ids[@]} - 1)) ]]; then
    next_index=0
else
    next_index=$((current_index + 1))
fi

# Switch to next source
next_id="${source_ids[$next_index]}"
next_name="${source_names[$next_index]}"

wpctl set-default "$next_id"

# Show notification
notify-send "Audio Source" "Switched to: $next_name" -t 2000