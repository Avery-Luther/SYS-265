# This script will add a new named user, update the ip to one specified in pos 1,
# change the default gateway, and change the host name to the one specified in pos 2 with -avery.
adduser avery
if [[ $3 == 'cent' ]]; then
	usermod -G wheel
	yum install vim -y
	echo "cent"
elif [[ $3 == 'ub' ]]; then
	usermod -G sudo,adm,cdrom,dip,plugdev,lxd
	apt install vim -y
	echo "ub"
else
	echo "Please specify an os"
fi

INTERFACE=$(ip link show | grep "2: " | awk '{print $2}')
ip addr add $1 dev ${INTERFACE:: -1}
echo "$1 ${INTERFACE::-1}"
HOSTNAME="${2}-avery"
hostname $HOSTNAME
echo $HOSTNAME
route add default 10.0.5.2

