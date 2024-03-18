#!/usr/bin/env bash
#secure-ssh.sh
#author Avery Luther
#Creates a new ssh user using the $1 parameter
#Adds a public key from the local repo or curled from the remote repo
#Removes roots ability to ssh in


useradd -m -d /home/$1 -s /bin/bash $1 
git clone https://github.com/Avery-Luther/SYS-265 /tmp/git
mkdir -p /home/$1/.ssh

chmod 700 /home/$1/.ssh
chown -R $1:$1 /home/$1/.ssh
cat /tmp/git/linux/public-keys/id_rsa.pub >> /home/$1/.ssh/authorized_keys
chown $1:$1 /home/$1/.ssh/authorized_keys
chmod 600 /home/$1/.ssh/authorized_keys

SSHFILE=$(cat /etc/ssh/sshd_config | grep "DenyUsers")
SSHCON="DenyUsers root"
if [ "$SSHFILE" != "$SSHCON" ]; then
	echo "DenyUsers root" >> /etc/ssh/sshd_config;
else
	echo "Already Denying Root";
fi
systemctl restart sshd
rm -rf /tmp/git
