# Script for forward ip with iptables
# 
# Author: alozo(github.com/alozoBack)


clear

echo ""


echo " /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\ ";
echo "( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )";
echo " > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ < ";
echo " /\_/\                                                                                                    /\_/\ ";
echo "( o.o )      ._____________  __________________ __________ __      __  _____ __________________          ( o.o )";
echo " > ^ <       |   \______   \ \_   _____\_____  \\______   /  \    /  \/  _  \\______   \______ \          > ^ < ";
echo " /\_/\       |   ||     ___/  |    __)  /   |   \|       _\   \/\/   /  /_\  \|       _/|    |  \         /\_/\ ";
echo "( o.o )      |   ||    |      |     \  /    |    |    |   \\        /    |    |    |   \|    |   \       ( o.o )";
echo " > ^ <       |___||____|      \___  /  \_______  |____|_  / \__/\  /\____|__  |____|_  /_______  /        > ^ < ";
echo " /\_/\                            \/           \/       \/       \/         \/       \/        \/         /\_/\ ";
echo "( o.o )                                                                                                  ( o.o )";
echo " > ^ <                                                                                                    > ^ < ";
echo " /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\ ";
echo "( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )";
echo " > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ < ";

echo ""

echo "Origin IP: "
read origin
echo "Destination IP: "
read dest
echo "Port: "
read port
echo "Protocol(udp/tcp): "
read protocol
case $protocol in
    "tcp")
    sudo iptables -t nat -A PREROUTING -p tcp -d $origin --dport $port -j DNAT --to-destination $dest:$port ; \
    sudo iptables -A FORWARD -p tcp -d $dest:$port --dport $port -j ACCEPT
        ;;
    "udp")
    sudo iptables -t nat -A PREROUTING -p udp -d $origin --dport $port -j DNAT --to-destination $dest:$port ; \
    sudo iptables -A FORWARD -p udp -d $dest --dport $port:$port -j ACCEPT
        ;;
        *)
    echo "invalid"
    ;;
esac
