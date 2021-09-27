
#!/bin/bash

# CREATE NFS SERVER STORAGE ON K8S MASTER NODE

sudo yum -y install nfs-utils
sudo systemctl enable nfs-server
sudo systemctl start nfs-server
sudo mkdir -p /mnt/nfs_shares
sudo chown -R nobody: /mnt/nfs_shares
sudo chmod -R 777 /mnt/nfs_shares
sudo systemctl restart nfs-server

echo '##################### INSTALLING NFS MOUNT #######################'
sudo sh -c "echo '/mnt/nfs_shares  10.0.0.30/24(rw,sync,no_root_squash)'>/etc/exports"
sudo exportfs -arv
echo '################# CHECKING NFS MOUNT IS IN PLACE #################'
sudo exportfs -s


# MOUNT THE NFS SHARE ON  K8S MASTER NODE

# K8s MASTER
sudo yum install nfs-utils nfs4-acl-tools -y
echo '################### INSTALLING LOCAL SHARED DIR #################'
sudo mkdir -p /home/centos/nfs
sudo mount -t nfs 10.0.0.30:/mnt/nfs_shares /home/centos/nfs
