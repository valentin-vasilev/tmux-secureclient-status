#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helpers.sh"

kernel_name=$(uname -s)

vpn_connected_icon=""
vpn_disconnected_icon=""

vpn_connected_icon_default=" "
vpn_disconnected_icon_default=" "

vpn_ip_address_default=0

update_vpn_icon() {
	vpn_connected_icon=$(get_tmux_option "@vpn_connected_icon" "$vpn_connected_icon_default")
	vpn_disconnected_icon=$(get_tmux_option "@vpn_disconnected_icon" "$vpn_disconnected_icon_default")
}

update_ip_address_display() {
	ip_address_display=$(get_tmux_option "@vpn_ip_address" "$vpn_ip_address_default")
}

vpn_status() {
	if [ "$kernel_name" == "Darwin" ]; then
		# fetch system network information
		secure_client_stats=$(/opt/cisco/secureclient/bin/vpn stats)
		if grep -q "Connection State:            Connected" <<< "$secure_client_stats"; then
			secure_client_ipv4=$(grep "Client Address (IPv4):" <<< "$secure_client_stats" | awk '{ print $4 }')
			if [ $ip_address_display -eq 1 ]; then
				echo "$vpn_connected_icon [$secure_client_ipv4]"
			else
				echo "$vpn_connected_icon"
			fi
		else
		echo "$vpn_disconnected_icon"
		fi
	else
	echo " "
	exit 1
	fi
}

main() {
	update_vpn_icon
	update_ip_address_display
	vpn_status
}

main
