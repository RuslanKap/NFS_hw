#!/bin/bash
sudo su
yum install -y nfs-utils
systemctl enable firewalld --now
firewall-cmd --add-service="nfs3" \
  --add-service="rpc-bind" \
  --add-service="mountd" \
  --permanent
firewall-cmd --reload
systemctl enable nfs-server
systemctl start nfs-server
mkdir -p /srv/share/upload
chown -R nfsnobody:nfsnobody /srv/share
chmod 0777 /srv/share/upload
echo "/srv/share 192.168.56.11/32(rw,sync,root_squash)" >> /etc/exports
exportfs -a
systemctl restart nfs-server


