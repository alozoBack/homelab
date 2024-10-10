#!/bin/bash
# Script for forwarding IP with nftables
#
# Author: alozo (github.com/alozoBack)


# Usage info
function show_help {
    echo "Usage: $0 [-t] [-u] [-d destination] [-o origin] [-p port]"
    echo "  -t                 Use TCP protocol"
    echo "  -u                 Use UDP protocol"
    echo "  -d destination     Destination IP"
    echo "  -o origin          Origin IP"
    echo "  -p port            Port to forward"
}

# Initialize variables
protocol=""
origin=""
dest=""
port=""

# Parse command line arguments using getopts
while getopts "tud:o:p:h" opt; do
  case ${opt} in
    t )
      protocol="tcp"
      ;;
    u )
      protocol="udp"
      ;;
    d )
      dest=$OPTARG
      ;;
    o )
      origin=$OPTARG
      ;;
    p )
      port=$OPTARG
      ;;
    h )
      show_help
      exit 0
      ;;
    \? )
      show_help
      exit 1
      ;;
  esac
done

# Check if all required arguments are provided
if [ -z "$protocol" ] || [ -z "$origin" ] || [ -z "$dest" ] || [ -z "$port" ]; then
  echo "Error: Missing required arguments."
  show_help
  exit 1
fi

# Make sure nftables table and chains exist
nft add table ip nat
nft add chain ip nat prerouting { type nat hook prerouting priority 0 \; }
nft add chain ip nat postrouting { type nat hook postrouting priority 100 \; }

# Apply nftables rules based on protocol
if [ "$protocol" == "tcp" ]; then
  nft add rule ip nat prerouting ip daddr $origin tcp dport $port dnat to $dest:$port
  nft add rule ip nat postrouting ip saddr $dest oifname eth0 masquerade
elif [ "$protocol" == "udp" ]; then
  nft add rule ip nat prerouting ip daddr $origin udp dport $port dnat to $dest:$port
  nft add rule ip nat postrouting ip saddr $dest oifname eth0 masquerade
else
  echo "Invalid protocol selected."
  exit 1
fi

echo "Forwarding rule added: $origin -> $dest on port $port using $protocol"
