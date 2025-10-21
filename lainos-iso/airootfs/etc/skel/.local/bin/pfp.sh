#!/usr/bin/env bash

# --------------------------------------------------------------------------------------------------
#
# Change the `hyprlock` profile picture on startup.
#
# --------------------------------------------------------------------------------------------------

pfp_dir="/usr/share/LainOS/pfp"
config_file="${XDG_CONFIG_HOME:-$HOME/.config}/hypr/hyprlock.conf"

pictures=("$pfp_dir"/*)
last_pfp=$(grep "path = /usr/share/LainOS/pfp" "$XDG_CONFIG_HOME/hypr/hyprlock.conf" |
	sed -E 's/    path = //')

# Filter out the last used picture to avoid repetition
filtered_pictures=()
for p in "${pictures[@]}"; do
	if [ "$p" != "$last_pfp" ]; then
		filtered_pictures+=("$p")
	fi
done

# Shuffle the list and pick the first one
new_pfp=$(printf "%s\n" "${filtered_pictures[@]}" | shuf -n 1)

# Update the config file with the new picture path
sed -i "s|path = /usr/share/LainOS/pfp/.*|path = /usr/share/LainOS/pfp/${new_pfp##*/}|" "$config_file"
