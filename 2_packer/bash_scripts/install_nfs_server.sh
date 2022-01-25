
#!/bin/bash

#CREATE LOCAL RESOURCE DIRECTORIES
sudo mkdir -p /home/centos/nfs
sudo mkdir -p /home/centos/nfs/pv-nfs1
sudo mkdir -p /home/centos/nfs/pv-nfs2
sudo mkdir -p /home/centos/nfs/pv-nfs-rwo1
sudo mkdir -p /home/centos/nfs/pv-nfs-rwo2
sudo mkdir -p /home/centos/nfs/pv-nfs-rwo3
sudo mkdir -p /home/centos/nfs/pv-nfs-rwo4
sudo mkdir -p /home/centos/nfs/pv-nfs-rwo5
sudo mkdir -p /home/centos/nfs/pv-nfs-rwo6

# CREATE NFS SERVER STORAGE ON K8S MASTER NODE

sudo yum -y install nfs-utils
sudo systemctl enable nfs-server
sudo systemctl start nfs-server
sudo mkdir -p /mnt/nfs_shares
sudo mkdir -p /mnt/nfs_shares/pv-nfs1
sudo mkdir -p /mnt/nfs_shares/pv-nfs2
sudo mkdir -p /mnt/nfs_shares/pv-nfs-rwo1
sudo mkdir -p /mnt/nfs_shares/pv-nfs-rwo2
sudo mkdir -p /mnt/nfs_shares/pv-nfs-rwo3
sudo mkdir -p /mnt/nfs_shares/pv-nfs-rwo4
sudo mkdir -p /mnt/nfs_shares/pv-nfs-rwo5
sudo mkdir -p /mnt/nfs_shares/pv-nfs-rwo6


sudo chown -R nobody: /mnt/nfs_shares
sudo chmod -R 777 /mnt/nfs_shares
sudo systemctl restart nfs-server

echo '##################### INSTALLING NFS MOUNT #######################'
sudo sh -c "echo '/mnt/nfs_shares/pv-nfs1  10.0.0.30/24(rw,sync,no_root_squash)'>/etc/exports"
sudo sh -c "echo '/mnt/nfs_shares/pv-nfs2  10.0.0.30/24(rw,sync,no_root_squash)'>>/etc/exports"
sudo sh -c "echo '/mnt/nfs_shares/pv-nfs-rwo1  10.0.0.30/24(rw,sync,no_root_squash)'>>/etc/exports"
sudo sh -c "echo '/mnt/nfs_shares/pv-nfs-rwo2  10.0.0.30/24(rw,sync,no_root_squash)'>>/etc/exports"
sudo sh -c "echo '/mnt/nfs_shares/pv-nfs-rwo3  10.0.0.30/24(rw,sync,no_root_squash)'>>/etc/exports"
sudo sh -c "echo '/mnt/nfs_shares/pv-nfs-rwo4  10.0.0.30/24(rw,sync,no_root_squash)'>>/etc/exports"
sudo sh -c "echo '/mnt/nfs_shares/pv-nfs-rwo5  10.0.0.30/24(rw,sync,no_root_squash)'>>/etc/exports"
sudo sh -c "echo '/mnt/nfs_shares/pv-nfs-rwo6  10.0.0.30/24(rw,sync,no_root_squash)'>>/etc/exports"


sudo exportfs -arv
echo '################# CHECKING NFS MOUNT IS IN PLACE #################'
sudo exportfs -s


# MOUNT THE NFS SHARE ON  K8S MASTER NODE

# K8s MASTER
sudo yum install nfs-utils nfs4-acl-tools -y
echo '################### INSTALLING LOCAL SHARED DIR #################'



sudo mount -t nfs 10.0.0.30:/mnt/nfs_shares/pv-nfs1 /home/centos/nfs/pv-nfs1
sudo mount -t nfs 10.0.0.30:/mnt/nfs_shares/pv-nfs2 /home/centos/nfs/pv-nfs2
sudo mount -t nfs 10.0.0.30:/mnt/nfs_shares/pv-nfs-rwo1 /home/centos/nfs/pv-nfs-rwo1
sudo mount -t nfs 10.0.0.30:/mnt/nfs_shares/pv-nfs-rwo2 /home/centos/nfs/pv-nfs-rwo2
sudo mount -t nfs 10.0.0.30:/mnt/nfs_shares/pv-nfs-rwo3 /home/centos/nfs/pv-nfs-rwo3
sudo mount -t nfs 10.0.0.30:/mnt/nfs_shares/pv-nfs-rwo4 /home/centos/nfs/pv-nfs-rwo4
sudo mount -t nfs 10.0.0.30:/mnt/nfs_shares/pv-nfs-rwo5 /home/centos/nfs/pv-nfs-rwo5
sudo mount -t nfs 10.0.0.30:/mnt/nfs_shares/pv-nfs-rwo6 /home/centos/nfs/pv-nfs-rwo6



