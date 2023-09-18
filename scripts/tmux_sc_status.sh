#!/usr/bin/env bash

kernel_name=$(uname -s)

vpn_status() {
	if [ "$kernel_name" == "Darwin" ]; then
		# fetch system network information
		network_information=$(scutil --nwi)
		secure_client_stats=$(/opt/cisco/secureclient/bin/vpn stats)
		if grep -q "Connection State:            Connected" <<< "$secure_client_stats"; then
		echo ""
	else
		echo ""
		fi
	else
	echo " "
	exit 1
	fi
}

main() {
	vpn_status
}

main
