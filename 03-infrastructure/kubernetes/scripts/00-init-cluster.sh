#!/bin/bash
set -e

echo "╔════════════════════════════════════════════════════╗"
echo "║  INICIALIZACIÓN KUBERNETES CLUSTER - NODO MASTER    ║"
echo "╚════════════════════════════════════════════════════╝"

# ===== FASE 1: Pre-requisitos =====
echo ""
echo "FASE 1: Pre-requisitos en sistema"

sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget git vim net-tools openssh-server ufw htop iotop

echo "Desactivando swap..."
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

echo "Configurando kernel..."
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf > /dev/null
overlay
br_netfilter
EOF
sudo modprobe overlay
sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf > /dev/null
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward = 1
EOF
sudo sysctl --system > /dev/null

# ===== FASE 2: Container Runtime =====
echo ""
echo "FASE 2: Instalar containerd"

curl https://get.docker.com | bash
sudo usermod -aG docker $USER

sudo apt install -y containerd.io
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml > /dev/null
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml
sudo systemctl restart containerd
sudo systemctl enable containerd

# ===== FASE 3: Kubernetes =====
echo ""
echo "FASE 3: Instalar Kubernetes v1.32"

sudo apt-get install -y apt-transport-https ca-certificates curl gpg
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | \
  sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | \
  sudo tee /etc/apt/sources.list.d/kubernetes.list > /dev/null

sudo apt-get update
sudo apt-get install -y kubelet=1.32.0-1.1 kubeadm=1.32.0-1.1 kubectl=1.32.0-1.1
sudo apt-mark hold kubelet kubeadm kubectl
sudo systemctl enable kubelet

# ===== FASE 4: Firewall =====
echo ""
echo "FASE 4: Configurar firewall"

sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow 6443/tcp          # API Server
sudo ufw allow 2379:2380/tcp     # etcd
sudo ufw allow 10250/tcp         # Kubelet API
sudo ufw allow 10251/tcp         # Scheduler
sudo ufw allow 10252/tcp         # Controller Manager
sudo ufw allow 30000:32767/tcp   # NodePort
sudo ufw enable -y

# ===== FASE 5: kubeadm init =====
echo ""
echo "FASE 5: Inicializar Master con kubeadm"

sudo kubeadm init \
  --apiserver-advertise-address=100.122.86.65 \
  --control-plane-endpoint=100.122.86.65:6443 \
  --pod-network-cidr=10.244.0.0/16 \
  --service-cidr=10.96.0.0/12 \
  --kubernetes-version=v1.32.0 \
  --upload-certs \
  --config=03-infrastructure/kubernetes/base/kubeadm-config.yaml

# ===== FASE 6: kubectl config =====
echo ""
echo "FASE 6: Configurar kubectl"

mkdir -p $HOME/.kube
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# ===== FASE 7: Helm =====
echo ""
echo "FASE 7: Instalar Helm"

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
helm repo add stable https://charts.helm.sh/stable
helm repo update

echo ""
echo "╔════════════════════════════════════════════════════╗"
echo "║  ✅ MASTER INICIALIZADO                            ║"
echo "╚════════════════════════════════════════════════════╝"

echo ""
echo "Próximos pasos:"
echo "1. En NODO MASTER ejecutar:"
echo "   bash 03-infrastructure/kubernetes/scripts/01-join-worker.sh"
echo ""
echo "2. En NODO WORKER ejecutar:"
echo "   bash 03-infrastructure/kubernetes/scripts/00-init-cluster.sh"
echo ""
echo "3. Luego en MASTER:"
echo "   bash 03-infrastructure/kubernetes/scripts/02-install-cni.sh"
