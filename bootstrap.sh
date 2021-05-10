#!/bin/bash
swapoff -a
timedatectl set-timezone America/Sao_Paulo
apt-get update
apt-get -y dist-upgrade
apt-get -y install bash-completion
cat > /etc/modules-load.d/k8s.conf << EOF
br_netfilter
ip_vs
ip_vs_rr
ip_vs_sh
ip_vs_wrr
EOF
curl -fsSL https://get.docker.com | bash
apt-get update && apt-get install -y apt-transport-https ca-certificates
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubelet kubeadm kubectl
kubectl completion bash | tee /etc/bash_completion.d/kubectl
sed -i "s/cgroup-driver=systemd/cgroup-driver=cgroupfs/g" /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
systemctl daemon-reload
systemctl restart kubelet
