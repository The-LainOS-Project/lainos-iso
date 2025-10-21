#!/bin/bash

# Refactored lesme-snowflake.sh functions for secure passphrase handling

# --- Global Settings and Error Handling ---

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error
set -u
# Use a custom function for error handling
trap 'handle_error "An unexpected error occurred. See previous output for details."' ERR

# --- Utility Functions ---

# Function to handle errors
handle_error() {
	# $1 contains the custom error message
	echo "Error: $1" >&2
	exit 1
}

# Function to generate a random string
generate_random_string() {
	# Generates 24 bytes (48 hex chars)
	openssl rand -hex 24
}

# --- Core Logic Functions ---

# Function to generate a GPG key, securely taking the passphrase via a file descriptor.
generate_gpg_key() {
	# Check if the required variable is set
	if [ -z "${GPG_PASSPHRASE}" ]; then
		handle_error "GPG_PASSPHRASE is not set. Cannot generate key."
	fi

	local RANDOM_NAME=$(generate_random_string)
	local RANDOM_EMAIL="${RANDOM_NAME}@example.com"
	local GPG_FINGERPRINT_TEMP

	# Create a temporary file descriptor (3) to securely pipe the passphrase.
	exec 3< <(echo "$GPG_PASSPHRASE")

	gpg --batch --passphrase-fd 3 --gen-key <<EOF || handle_error "GPG key generation failed."
%echo Generating a default key
Key-Type: RSA
Key-Length: 4096
Subkey-Type: RSA
Subkey-Length: 4096
Name-Real: $RANDOM_NAME
Name-Email: $RANDOM_EMAIL
Expire-Date: 0
%commit
%echo done
EOF

	exec 3<&- # Close the temporary file descriptor

	# Clear passphrase variables immediately after use for security
	unset GPG_PASSPHRASE

	# Retrieve the fingerprint of the newly generated key (using 'fpr' is most reliable).
	GPG_FINGERPRINT_TEMP=$(gpg --list-keys --with-colons | grep '^fpr' | awk -F: '{print $10}' | tail -n 1)

	if [ -z "$GPG_FINGERPRINT_TEMP" ]; then
		handle_error "Unable to retrieve GPG fingerprint."
	fi

	# Export the final fingerprint for use by 'pass init'
	export GPG_FINGERPRINT="$GPG_FINGERPRINT_TEMP"
	echo "Your GPG fingerprint is: $GPG_FINGERPRINT"
}

# Function to prompt for the GPG passphrase
prompt_gpg_passphrase() {
	local GPG_PASSPHRASE_CONFIRM # Use local scope for the confirm variable

	echo "********************************************************************"
	echo "Create a new PGP passphrase (ALPHANUMERIC ONLY, NO SPECIAL CHARACTERS)."
	echo "MINIMUM 12 CHARACTERS."
	echo ""
	echo "This passphrase lets you log into the LESME framework, and the framework"
	echo "decrypts your PGP encrypted XMPP account passphrase which you will enter later"
	echo "in this script. Adjust this PGP passphrase to your threat model, this is not your"
	echo "XMPP account passphrase, which should be generated on LainOS using Keepass"
	echo "with 45 characters, and SPECIAL CHARACTERS DISABLED"

	while true; do
		read -s -p "Enter a new PGP passphrase: " GPG_PASSPHRASE
		echo ""
		read -s -p "Confirm your GPG passphrase: " GPG_PASSPHRASE_CONFIRM
		echo ""

		# 1. Combined Complexity and Length Check (12+ chars, includes upper, lower, number)
		if [[ ${#GPG_PASSPHRASE} -lt 12 || ! "$GPG_PASSPHRASE" =~ [a-z] || ! "$GPG_PASSPHRASE" =~ [A-Z] || ! "$GPG_PASSPHRASE" =~ [0-9] ]]; then
			echo "Error: GPG passphrase must be at least 12 characters long and include uppercase, lowercase, and numbers. Please try again." >&2
			continue
		fi

		# 2. Special character check (ALPHANUMERIC ONLY)
		if [[ "$GPG_PASSPHRASE" =~ [^a-zA-Z0-9] ]]; then
			echo "Error: GPG passphrase must contain ALPHANUMERIC characters only (A-Z, a-z, 0-9). Please try again." >&2
			continue
		fi

		# 3. Match check
		if [ "$GPG_PASSPHRASE" != "$GPG_PASSPHRASE_CONFIRM" ]; then
			echo "Error: GPG passphrases do not match. Please try again." >&2
			continue
		fi

		break # Validation passed
	done

	export GPG_PASSPHRASE
}

# Function to prompt for XMPP account
prompt_xmpp_account() {
	echo "********************************************************************"
	read -p "Enter your XMPP account (your_username@server.onion): " XMPP_ACCOUNT

	# Robust regex for a simple JID (user@domain), specifically allowing .onion
	if ! [[ "$XMPP_ACCOUNT" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.([a-zA-Z]{2,}|onion)$ ]]; then
		handle_error "Invalid XMPP account format. Must be like user@server.onion."
	fi
	export XMPP_ACCOUNT # Export for other functions
}

# Function to install required applications
install_required_apps() {
	echo "Updating the system..."
	if ! sudo pacman -Syyu --noconfirm; then
		echo "Warning: System update failed. Attempting to proceed with install."
	fi

	echo "Installing required applications..."
	# obfs4proxy is REMOVED as per user request (already installed)
	required_apps=(gnupg profanity pass tor torsocks onionshare openntpd)
	if ! sudo pacman -S --noconfirm "${required_apps[@]}"; then
		handle_error "Failed to install required applications."
	fi
}

# Function to configure Tor
configure_tor() {
	echo "Configuring Tor with obfs4 bridges..."

	local TORRC="/etc/tor/torrc"
	local BACKUP_TORRC="${TORRC}.bak.$(date +%Y%m%d%H%M%S)"
	sudo cp "$TORRC" "$BACKUP_TORRC" || handle_error "Failed to backup $TORRC."
	echo "Backup of the original torrc created at: $BACKUP_TORRC"

	# The config assumes /usr/bin/obfs4proxy is present.
	sudo bash -c "cat <<EOT >> $TORRC
# --- LESME CONFIGURATION START ---
# Use bridges
UseBridges 1
ClientTransportPlugin obfs4 exec /usr/bin/obfs4proxy managed
Bridge obfs4 89.217.174.207:9001 B64C5A360D530633CB2D8DEC5D19CA35C4360C93 cert=aJecxsni6mgSTU0BPz3v0W7GA+RmjuDFA7NF+KffQNydMX7npDvjqrCXRnzY0ym9EKlLTw iat-mode=0
Bridge obfs4 86.30.100.123:42957 F3FA0D45D35E987484848345F8D92AB1D883889B cert=cxC0DfySYT/IBGBesOq64QKHCl5WdiR08qxcdsCpbpkj/2m6vwzpCFsP6m8r/+ZhdC26CA iat-mode=0
# --- LESME CONFIGURATION END ---
EOT" || handle_error "Failed to append Tor configuration."

	echo "Disabling Tor from starting on boot..."
	sudo systemctl disable tor || echo "Warning: Tor service may already be disabled or missing."

	echo "Stopping Tor service..."
	sudo systemctl stop tor || echo "Warning: Tor service was not running or failed to stop."
}

# Function to initialize Pass with GPG fingerprint
initialize_pass() {
	echo "Using GPG fingerprint: $GPG_FINGERPRINT"
	echo "Initializing Pass with the GPG fingerprint..."
	pass init "$GPG_FINGERPRINT" || handle_error "Failed to initialize Pass. Ensure GnuPG is set up."
}

# Function to store XMPP account password in Pass
store_xmpp_password() {
	echo "Storing your XMPP account password in Pass..."
	echo "********************************************************************"
	echo "You will now be prompted to enter and confirm your XMPP password."
	if ! pass insert "entry/$XMPP_ACCOUNT"; then
		handle_error "Failed to store the XMPP account password in Pass."
	fi
}

# Function to update shell configuration
update_shell_config() {
	local SHELL_CONFIG

	# FIXED: Safely check for .zshrc existence (avoids "unbound variable" error when using set -u)
	if [ -e "$HOME/.zshrc" ]; then
		SHELL_CONFIG="$HOME/.zshrc"
	else
		# Default to bashrc if zshrc isn't found
		SHELL_CONFIG="$HOME/.bashrc"
	fi

	local START_NTP_COMMAND="sudo systemctl start openntpd"

	if ! grep -q "$START_NTP_COMMAND" "$SHELL_CONFIG"; then
		echo "Appending '$START_NTP_COMMAND' to $SHELL_CONFIG"
		echo -e "\n# Start openntpd for time synchronization (LESME requirement)" >>"$SHELL_CONFIG"
		echo "$START_NTP_COMMAND" >>"$SHELL_CONFIG"
	fi
}

# Function to pre-configure Profanity
start_profanity() {
	echo "Pre-configuring Profanity account settings..."
	# FIX: Removed the '-n' option as it caused the "Unknown option -n" error.
	torsocks profanity <<EOF
/history off
/theme load forest
/account add $XMPP_ACCOUNT
/account set $XMPP_ACCOUNT eval_password "pass entry/$XMPP_ACCOUNT"
/omemo policy automatic
/omemo trustmode blind
/save
/quit
EOF
}

# Function to prompt user for Profanity login
prompt_profanity_login() {
	echo "********************************************************************"
	read -p "Press y to test your pgp login for profanity, then type /quit to finish the script (y/n): " log_in_choice
	echo "Your login command will be in the post installation intructions below, and you can paste it into your password manager"

	if [[ "$log_in_choice" =~ ^[Yy]$ ]]; then
		torsocks profanity -a "$XMPP_ACCOUNT"
	else
		echo "You can log in to Profanity later by running: torsocks profanity -a $XMPP_ACCOUNT"
	fi
}

# Function to clear sensitive data
clear_sensitive_data() {
	echo "********************************************************************"
	echo "Clearing terminal data for security..."
	history -c
	unset HISTFILE
	echo "All sensitive data has been securely wiped from the current session's memory."
}

# --- Main Script Execution ---

echo "********************************************************************"
echo "Welcome to the LainOS Ephemeral Secure Messaging Environment (LESME)"
echo "Install/Config Script!"
echo ""
echo "Before using this script, you need to create an account on the LainOS Onion XMPP"
echo "server. This may be illegal in your country(so I have to tell you not to use it"
echo "in those countries). please visit:"
echo "https://gitlab.com/lainos/lainos-onion-xmpp-server-guide or the LainOS"
echo "Discord/Matrix to learn how to create an account or have one created for you"

# 1. Prompt for and validate GPG passphrase
prompt_gpg_passphrase

# 2. Generate GPG key and export fingerprint
generate_gpg_key

# 3. Prompt for XMPP account
prompt_xmpp_account

# 4. Install dependencies
install_required_apps

# 5. Configure Tor
configure_tor

# 6. Initialize Pass
initialize_pass

# 7. Store XMPP password securely
store_xmpp_password

# 8. Update shell config to start openntpd on login
update_shell_config

# 9. Pre-configure Profanity
start_profanity

# 10. Prompt for immediate login
prompt_profanity_login

# 11. Clear sensitive data
clear_sensitive_data

# --- Final Instructions ---

echo "LESME installation complete! Enjoy secure comms on LainOS! And follow the"
echo "post-installation instructions below"
echo ""
echo "Now use 'sudo systemctl start tor' because this script disconnects you from"
echo "Tor, then open a terminal and issue the command 'nyx' to open the Tor real-time"
echo "connection monitor. "
echo ""
echo "Then you can connect to the LainOS Secure Messaging Server by issuing the"
echo "command 'torsocks profanity -a $XMPP_ACCOUNT', and you will be prompted for"
echo "your PGP passphrase you entered in the beginning of the script which decrypts"
echo "your XMPP account passphrase and securely pipes it into profanity to log you in."
echo ""
echo "Once in Profanity, accept the server TLS certificate by typing '/tls allow."
echo "After a few seconds you will see that you have connected to the LainOS XMPP"
echo "server(TLS cert Fractal Technologies LTD/Ill Communications)."
echo""
echo "To join the LainOS chatroom, in profanity issue the command:"
echo "/join private-chat-c75bebbc-50f3-447d-811f-41f83de11811@conference.glcuf4hcwbm3lt6grg7jfwwus7sqpuojozfsnbzzcsf7vbm2jcfqckid.Onion"
echo ""
echo "Enjoy the LainOS Secure Messaging Server!"

exit 0
