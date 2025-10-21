#!/bin/zsh
# Description: Manages the Tor service using systemctl.
# Usage: ./tor_manager.sh <action>
# Actions: start, status, restart, stop

SERVICE="tor"
ACTION="$1"

# Check if an action was provided
if [ -z "$ACTION" ]; then
	echo "Error: Please specify an action (start (s), status (stat), restart (r), or stop (st))."
	echo "Usage: $0 <action>"
	exit 1
fi

# Convert action to lowercase for easier matching
ACTION_LOWER=$(echo "$ACTION" | tr '[:upper:]' '[:lower:]')

# Function to execute the command
execute_command() {
	echo "--- Executing: sudo systemctl $1 $SERVICE ---"
	sudo systemctl "$1" "$SERVICE"
	# The exit status of the sudo systemctl command is returned
	return $?
}

case "$ACTION_LOWER" in
s)
	execute_command "start"
	;;
stat)
	execute_command "status"
	;;
r)
	execute_command "restart"
	;;
st)
	execute_command "stop"
	;;
*)
	echo "Error: Invalid action '$ACTION'. Must be start, status, restart, or stop."
	exit 1
	;;
esac
