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
echo ""
echo "Destination IP: "
read dest
echo ""
echo "Port: "
read port
sudo iptables -t nat -A PREROUTING -p tcp -d $origin --dport $port -j DNAT --to-destination $dest
sudo iptables -A FORWARD -p tcp -d $dest --dport $port -j ACCEPT
