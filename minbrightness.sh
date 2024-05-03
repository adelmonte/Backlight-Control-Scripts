#!/bin/bash

while true; do
    # Get current brightness level
    current_brightness=$(cat /sys/class/backlight/intel_backlight/actual_brightness)

    # Check if brightness is 0
    if (( current_brightness == 0 )); then
        # If brightness is 0, calculate 1% of max brightness
        max_brightness=$(cat /sys/class/backlight/intel_backlight/max_brightness)
        one_percent=$(( max_brightness / 100 ))

        # Set brightness to 1%
        echo $one_percent | sudo tee /sys/class/backlight/intel_backlight/brightness > /dev/null
    fi

    # Wait for 1 second before checking again
    sleep 1
done & 
