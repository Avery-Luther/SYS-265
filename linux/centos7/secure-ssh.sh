#!/usr/bin/env bash
#secure-ssh.sh
#author Avery Luther
#Creates a new ssh user using the $1 parameter
#Adds a public key from the local repo or curled from the remote repo
#Removes roots ability to ssh in


adduser $1
passwd $1
git clone https://github.com/Avery-Luther/SYS-265 /tmp/git
cp /tmp/git/SYS-265/linux/public-keys/id_rsa.pub  /home/$1/.ssh/authorized_keys/id_rsa.pub


SSHFILE=$(cat /etc/ssh/sshd_config | grep "DenyUsers")
SSHCON="DenyUsers root"
if [ "$SSHFILE" != "$SSHCON" ]; then
	echo "DenyUsers root" >> /etc/ssh/sshd_config;
else
	echo "Already Denying Root";
fi
systemctl restart sshd
rm -rf /tmp/git
