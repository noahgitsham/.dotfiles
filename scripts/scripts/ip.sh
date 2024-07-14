#!/usr/bin/sh

OPTIND=1

public=false
private=false
verbose=false

while getopts "hvpP-" opt; do
	if [ "$opt" = "-" ]; then
		opt="${optarg%%=*}"
		optarg="${optarg#"$opt"}"
		optarg="${optarg#=}"
	fi
	if [ -z "$opt" ]; then
		public=true
		private=true
		verbose=true
		break
	fi
	case "$opt" in
		"h"|"help")
			echo "ip.sh - a simple script for getting your public and private IP addresses"
			echo ""
			echo "Usage:"
			echo "  ip.sh [options]"
			echo ""
			echo "Options:"
			echo "  -h --help     Display this messagge"
			echo "  -v --verbose  Output labels with each IP address"
			echo ""
			echo "  -p --public   Output public IP address(es)"
			echo "  -P --private  Output private IP address(es)"
			;;
		"v"|"verbose")
			verbose=true
			;;
		"p"|"public")
			public=true
		;;
		"P"|"private")
			private=true
		;;
	\?)
		exit 2 ;;
	*)
		echo "Illegal option --$opt"
		exit 2
	esac
done

if [ $public = true ]; then
	msg=""
	if [ $verbose = true ]; then
		msg="Public:  "
	fi
	echo "$msg$(curl -s icanhazip.com)"
fi
if [ $private = true ]; then
	msg=""
	if [ $verbose = true ]; then
		msg="Private: "
	fi
	echo "$msg$(hostname -i)"
fi
shift $((OPTIND-1))
