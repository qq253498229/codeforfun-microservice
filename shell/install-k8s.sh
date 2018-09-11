#!/usr/bin/env bash
#安装基础依赖
apt-get update && apt-get install -y apt-transport-https

#使用阿里云镜像
curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add -
cat << EOF >/etc/apt/sources.list.d/kubernetes.list

deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main

EOF
apt-get update

#安装Kubernetes
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl

#拉取k8s所需google镜像
images=(kube-proxy-amd64:v1.11.1 kube-controller-manager-amd64:v1.11.1 kube-scheduler-amd64:v1.11.1 kube-apiserver-amd64:v1.11.1 coredns:1.1.3 etcd-amd64:3.2.18 pause:3.1)


for image in ${images[@]}; do
  docker pull registry.cn-qingdao.aliyuncs.com/wangdali/$image
  docker tag registry.cn-qingdao.aliyuncs.com/wangdali/$image k8s.gcr.io/$image
  docker rmi registry.cn-qingdao.aliyuncs.com/wangdali/$image
done

#初始化集群
kubeadm init --kubernetes-version=v1.11.1 --pod-network-cidr 10.244.0.0/16

#安装网络组件
sysctl net.bridge.bridge-nf-call-iptables=1
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.10.0/Documentation/kube-flannel.yml

#拉取ingress所需镜像
docker pull registry.cn-qingdao.aliyuncs.com/wangdali/defaultbackend:1.4
docker tag registry.cn-qingdao.aliyuncs.com/wangdali/defaultbackend:1.4 gcr.io/google_containers/defaultbackend:1.4
docker rmi registry.cn-qingdao.aliyuncs.com/wangdali/defaultbackend:1.4

#初始化ingress
kubectl apply -f https://raw.githubusercontent.com/qq253498229/k8s/master/ingress/mandatory.yaml
