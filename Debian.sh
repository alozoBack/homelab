# Script for Debian VM installed in ProxMox
# Script does the following:
# 1. Installs packages: qemu-guset-agent, parted, ssh, sudo, openssl.
# 2. Resizes the root partition to the full size of the disk (parted /dev/sda resizepart 1 -1)
# 3. Setup the sshd daemon (Create in /etc/ssh/sshd_config.d/proxmox.conf and set port, setup security)
# 4. Setup the sudoers file (Create group, add to file group)
# 5. Creates a user with sudo group
# 6. Add to new user ssh authorized keys
#
# Author: alozo (github.com/alozoBack)

# Port for ssh
port=7346

# Update

echo "";


echo " /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\ ";
echo "( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )";
echo " > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ < ";
echo " /\_/\                                                                                             /\_/\ ";
echo "( o.o )   ____ ___           .___       __                                  __                    ( o.o )";
echo " > ^ <   |    |   \_____   __| _/____ _/  |_  ____     _________.__. ______/  |_  ____   _____     > ^ < ";
echo " /\_/\   |    |   |____ \ / __ |\__  \\   __\/ __ \   /  ___<   |  |/  ___|   __\/ __ \ /     \    /\_/\ ";
echo "( o.o )  |    |  /|  |_> > /_/ | / __ \|  | \  ___/   \___ \ \___  |\___ \ |  | \  ___/|  Y Y  \  ( o.o )";
echo " > ^ <   |______/ |   __/\____ |(____  /__|  \___  > /____  >/ ____/____  >|__|  \___  >__|_|  /   > ^ < ";
echo " /\_/\            |__|        \/     \/          \/       \/ \/         \/           \/      \/    /\_/\ ";
echo "( o.o )                                                                                           ( o.o )";
echo " > ^ <                                                                                             > ^ < ";
echo " /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\ ";
echo "( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )";
echo " > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ < ";


echo "";


apt-get update

# Install packages
echo " "




echo " /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\ ";
echo "( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )";
echo " > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ < ";
echo " /\_/\                                                                                                           /\_/\ ";
echo "( o.o )   .___                __         .__  .__                         __                                    ( o.o )";
echo " > ^ <    |   | ____   ______/  |______  |  | |  |   ___________    ____ |  | ______    ____   ____   ______     > ^ < ";
echo " /\_/\    |   |/    \ /  ___|   __\__  \ |  | |  |   \____ \__  \ _/ ___\|  |/ |__  \  / ___\_/ __ \ /  ___/     /\_/\ ";
echo "( o.o )   |   |   |  \\___ \ |  |  / __ \|  |_|  |__ |  |_> > __ \\  \___|    < / __ \/ /_/  >  ___/ \___ \     ( o.o )";
echo " > ^ <    |___|___|  /____  >|__| (____  /____/____/ |   __(____  /\___  >__|_ (____  |___  / \___  >____  >     > ^ < ";
echo " /\_/\             \/     \/           \/            |__|       \/     \/     \/    \/_____/      \/     \/      /\_/\ ";
echo "( o.o )        ᑫᵉᵐᵘ⁻ᵍᵘˢᵉᵗ⁻ᵃᵍᵉⁿᵗ ᵖᵃʳᵗᵉᵈ ˢˢʰ ˢᵘᵈᵒ ᵒᵖᵉⁿˢˢˡ                                                         ( o.o )";
echo " > ^ <                                                                                                           > ^ < ";
echo " /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\ ";
echo "( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )";
echo " > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ < ";




echo " "
echo "Packages to install: qumu-guest-agent, parted, ssh, sudo, openssl"
echo "Enter to continue"
read
echo " "
apt-get install -y qemu-guest-agent parted ssh sudo openssl

# Resize root partition
echo " "




echo " /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\ ";
echo "( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )";
echo " > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ < ";
echo " /\_/\                                                                                             /\_/\ ";
echo "( o.o )  __________              .__                                     __  .__                  ( o.o )";
echo " > ^ <   \______   \ ____   _____|__|_______ ____   ___________ ________/  |_|__| ____   ____      > ^ < ";
echo " /\_/\    |       _// __ \ /  ___/  \___   // __ \  \____ \__  \\_  __ \   __\  |/  _ \ /    \     /\_/\ ";
echo "( o.o )   |    |   \  ___/ \___ \|  |/    /\  ___/  |  |_> > __ \|  | \/|  | |  (  <_> )   |  \   ( o.o )";
echo " > ^ <    |____|_  /\___  >____  >__/_____ \\___  > |   __(____  /__|   |__| |__|\____/|___|  /    > ^ < ";
echo " /\_/\           \/     \/     \/         \/    \/  |__|       \/                           \/     /\_/\ ";
echo "( o.o )                                                                        /ᵈᵉᵛ/ˢᵈᵃ¹          ( o.o )";
echo " > ^ <                                                                                             > ^ < ";
echo " /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\ ";
echo "( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )";
echo " > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ < ";


echo " "

echo -e "Fix\n1\nYes" | parted /dev/sda  resizepart 1 100% ---pretend-input-tty

# Setup sshd daemon
echo " "




echo " /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\ ";
echo "( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )";
echo " > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ < ";
echo " /\_/\                                                                        /\_/\ ";
echo "( o.o )   _________       __                               .__         .___  ( o.o )";
echo " > ^ <   /   _____/ _____/  |_ __ ________     ______ _____|  |__    __| _/   > ^ < ";
echo " /\_/\   \_____  \_/ __ \   __\  |  \____ \   /  ___//  ___/  |  \  / __ |    /\_/\ ";
echo "( o.o )  /        \  ___/|  | |  |  /  |_> >  \___ \ \___ \|   Y  \/ /_/ |   ( o.o )";
echo " > ^ <  /_______  /\___  >__| |____/|   __/  /____  >____  >___|  /\____ |    > ^ < ";
echo " /\_/\          \/     \/           |__|          \/     \/     \/      \/    /\_/\ ";
echo "( o.o )                                                                      ( o.o )";
echo " > ^ <                                                                        > ^ < ";
echo " /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\ ";
echo "( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )";
echo " > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ < ";


echo " "

echo "
Port $port
PermitRootLogin yes
PasswordAuthentication no
PubkeyAuthentication yes
AuthorizedKeysFile	.ssh/authorized_keys
MaxAuthTries 3
MaxSessions 2
" > /etc/ssh/sshd_config.d/proxmox.conf
systemctl restart sshd

# Setup sudoers file
echo " "




echo " /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\ ";
echo "( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )";
echo " > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ < ";
echo " /\_/\                                                                                                                         /\_/\ ";
echo "( o.o )   _________       __                                                                .___                  .___        ( o.o )";
echo " > ^ <   /   _____/ _____/  |_ __ ________    __ __  ______ ___________  _____    ____    __| _/   ________ __  __| _/____     > ^ < ";
echo " /\_/\   \_____  \_/ __ \   __\  |  \____ \  |  |  \/  ___// __ \_  __ \ \__  \  /    \  / __ |   /  ___/  |  \/ __ |/  _ \    /\_/\ ";
echo "( o.o )  /        \  ___/|  | |  |  /  |_> > |  |  /\___ \\  ___/|  | \/  / __ \|   |  \/ /_/ |   \___ \|  |  / /_/ (  <_> )  ( o.o )";
echo " > ^ <  /_______  /\___  >__| |____/|   __/  |____//____  >\___  >__|    (____  /___|  /\____ |  /____  >____/\____ |\____/    > ^ < ";
echo " /\_/\          \/     \/           |__|                \/     \/             \/     \/      \/       \/           \/          /\_/\ ";
echo "( o.o )                                                                                                                       ( o.o )";
echo " > ^ <                                                                                                                         > ^ < ";
echo " /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\ ";
echo "( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )";
echo " > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ < ";


echo " "

groupadd sdwhl
echo "%sdwhl ALL=(ALL:ALL) ALL" > /etc/sudoers.d/sdwhl
chmod 440 /etc/sudoers.d/sdwhl

# Create user
echo " "
echo "Write username: "
read username
useradd -m -s /bin/bash -G sdwhl $username
    #Set password
    password=$(openssl rand -hex 6)
    echo "$username:$password" | chpasswd
# Add to user ssh authorized keys
mkdir -p /home/$username/.ssh
chmod 700 /home/$username/.ssh
echo " "
echo "Write ssh public key: "
read sshkey
echo $sshkey >> /home/$username/.ssh/authorized_keys
chown -R $username:$username /home/$username/.ssh

echo "Password for $username is: $password"