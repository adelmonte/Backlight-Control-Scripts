#!/bin/bash

brightness_file="/sys/class/backlight/intel_backlight/actual_brightness"
keyboard_backlight_file="/sys/class/leds/dell::kbd_backlight/brightness"

# Function to adjust keyboard backlight
function adjust_keyboard_backlight() {
    brightness=$(cat "$brightness_file")
    max_brightness=96000
    threshold=$((max_brightness * 15 / 100))

    if [ "$brightness" -lt "$threshold" ]; then
        echo 1 | sudo tee "$keyboard_backlight_file"
    else
        echo 0 | sudo tee "$keyboard_backlight_file"
    fi
}

# Monitor brightness changes using inotifywait
while true; do
    inotifywait -e modify "$brightness_file"
    adjust_keyboard_backlight
done
