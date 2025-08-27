#!/usr/bin/env bash

# Toggle Waybar visibility
# Simple toggle using SIGUSR1 signal like the original keybinding

pkill -SIGUSR1 waybar