#!/bin/bash
#install base dependency
apt-get update && apt-get install -y apt-transport-https

#use aliyun mirror
curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add -
cat << EOF >/etc/apt/sources.list.d/kubernetes.list

deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main

EOF
apt-get update

#install Kubernetes
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl

#pull images about google for k8s
docker pull registry.cn-qingdao.aliyuncs.com/wangdali/kube-proxy-amd64:v1.11.1
docker pull registry.cn-qingdao.aliyuncs.com/wangdali/kube-controller-manager-amd64:v1.11.1
docker pull registry.cn-qingdao.aliyuncs.com/wangdali/kube-scheduler-amd64:v1.11.1
docker pull registry.cn-qingdao.aliyuncs.com/wangdali/kube-apiserver-amd64:v1.11.1
docker pull registry.cn-qingdao.aliyuncs.com/wangdali/coredns:1.1.3
docker pull registry.cn-qingdao.aliyuncs.com/wangdali/etcd-amd64:3.2.18
docker pull registry.cn-qingdao.aliyuncs.com/wangdali/pause:3.1


docker tag registry.cn-qingdao.aliyuncs.com/wangdali/kube-proxy-amd64:v1.11.1 k8s.gcr.io/kube-proxy-amd64:v1.11.1
docker tag registry.cn-qingdao.aliyuncs.com/wangdali/kube-controller-manager-amd64:v1.11.1 k8s.gcr.io/kube-controller-manager-amd64:v1.11.1
docker tag registry.cn-qingdao.aliyuncs.com/wangdali/kube-scheduler-amd64:v1.11.1 k8s.gcr.io/kube-scheduler-amd64:v1.11.1
docker tag registry.cn-qingdao.aliyuncs.com/wangdali/kube-apiserver-amd64:v1.11.1 k8s.gcr.io/kube-apiserver-amd64:v1.11.1
docker tag registry.cn-qingdao.aliyuncs.com/wangdali/coredns:1.1.3 k8s.gcr.io/coredns:1.1.3
docker tag registry.cn-qingdao.aliyuncs.com/wangdali/etcd-amd64:3.2.18 k8s.gcr.io/etcd-amd64:3.2.18
docker tag registry.cn-qingdao.aliyuncs.com/wangdali/pause:3.1 k8s.gcr.io/pause:3.1


docker rmi registry.cn-qingdao.aliyuncs.com/wangdali/kube-proxy-amd64:v1.11.1
docker rmi registry.cn-qingdao.aliyuncs.com/wangdali/kube-controller-manager-amd64:v1.11.1
docker rmi registry.cn-qingdao.aliyuncs.com/wangdali/kube-scheduler-amd64:v1.11.1
docker rmi registry.cn-qingdao.aliyuncs.com/wangdali/kube-apiserver-amd64:v1.11.1
docker rmi registry.cn-qingdao.aliyuncs.com/wangdali/coredns:1.1.3
docker rmi registry.cn-qingdao.aliyuncs.com/wangdali/etcd-amd64:3.2.18
docker rmi registry.cn-qingdao.aliyuncs.com/wangdali/pause:3.1

#init cluster
kubeadm init --kubernetes-version=v1.11.1 --pod-network-cidr 10.244.0.0/16

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

#install network addon
sysctl net.bridge.bridge-nf-call-iptables=1
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.10.0/Documentation/kube-flannel.yml

#pull images about google for ingress
docker pull registry.cn-qingdao.aliyuncs.com/wangdali/defaultbackend:1.4
docker tag registry.cn-qingdao.aliyuncs.com/wangdali/defaultbackend:1.4 gcr.io/google_containers/defaultbackend:1.4
docker rmi registry.cn-qingdao.aliyuncs.com/wangdali/defaultbackend:1.4

#init ingress
kubectl apply -f https://raw.githubusercontent.com/qq253498229/k8s/master/ingress/mandatory.yaml
