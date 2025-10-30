#!/usr/bin/env bash

# Toggle Do Not Disturb mode for mako notifications
makoctl mode -t dnd

# Check if DND is currently active and show a notification
if makoctl mode | grep -q "dnd"; then
    # DND is ON - briefly disable DND to show the notification, then re-enable
    makoctl mode -r dnd
    notify-send -u low "Do Not Disturb" "Notifications disabled"
    sleep 2
    makoctl mode -a dnd
else
    # DND is OFF
    notify-send -u low "Do Not Disturb" "Notifications enabled"
fi
