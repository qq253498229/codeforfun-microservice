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

#defined images
images=(kube-proxy-amd64:v1.11.1 kube-controller-manager-amd64:v1.11.1 kube-scheduler-amd64:v1.11.1 kube-apiserver-amd64:v1.11.1 coredns:1.1.3 etcd-amd64:3.2.18 pause:3.1)

#pull images about google for k8s
for image in ${images[@]}; do
  docker pull registry.cn-qingdao.aliyuncs.com/wangdali/$image
  docker tag registry.cn-qingdao.aliyuncs.com/wangdali/$image k8s.gcr.io/$image
  docker rmi registry.cn-qingdao.aliyuncs.com/wangdali/$image
done

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
