dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo

dnf install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm

dnf install docker-ce --nobest -y





#dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo

#dnf install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm -y
#dnf install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm -y

#dnf install docker-ce -y

#dnf install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-ce-18.06.3.ce-3.el7.x86_64.rpm -y

systemctl enable docker
systemctl start docker

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF

dnf upgrade -y
dnf install -y kubelet-1.19.0 kubeadm-1.19.0 kubectl-1.19.0 --disableexcludes=kubernetes


#dnf install kubeadm -y 
systemctl enable kubelet
systemctl start kubelet

swapoff -a
