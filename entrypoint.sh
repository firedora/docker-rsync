#!/bin/sh

mkdir -p /root/.ssh
chmod 700 /root/.ssh

touch /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys

sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config
sed -i 's/root:!/root:*/' /etc/shadow

if [ ! -e /etc/ssh/ssh_host_rsa_key.pub ]; then
	ssh-keygen -A
fi

if [ ! -e /root/.ssh/id_rsa.pub ]; then
  ssh-keygen -q -N "" -f /root/.ssh/id_rsa
fi

if [ $1 == "server" ]; then
	# AUTH=`cat /root/.ssh/authorized_keys`
	# if [ -z "$AUTH" ]; then
	# 	echo "ERROR: No SSH_AUTH_KEY provided, you'll not be able to connect to this container. "
	# 	exit 1
	# fi

	SSH_PARAMS="-e -p ${SSH_PORT:-22} $SSH_PARAMS"
	echo "Running: /usr/sbin/sshd $SSH_PARAMS"

	exec /usr/sbin/sshd -D $SSH_PARAMS
	rsync --daemon
fi

if [ $1 == "client" ]; then
	exec /usr/sbin/crond -f
	echo "Please add this ssh key to your server /home/user/.ssh/authorized_keys"
	echo "`cat /root/.ssh/id_rsa.pub`"
fi
