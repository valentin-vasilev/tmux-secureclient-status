#!/usr/bin/env bash

kernel_name=$(uname -s)

vpn_status() {
	if [ "$kernel_name" == "Darwin" ]; then
		# fetch system network information
		secure_client_stats=$(/opt/cisco/secureclient/bin/vpn stats)
		if grep -q "Connection State:            Connected" <<< "$secure_client_stats"; then
			secure_client_ipv4=$(grep "Client Address (IPv4):" <<< "$secure_client_stats" | awk '{ print $4 }')
			echo "󰦝 [$secure_client_ipv4]"
	else
		echo "󱦚 "
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
