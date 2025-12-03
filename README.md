# ramen-de-dockers
Es donde se estan guarando las config de los docker para el servidor on.premise personal


CNI:
sudo kubeadm init \
    --pod-network-cidr=10.244.0.0/16 \
    --apiserver-advertise-address=100.122.86.65
    
Hacer la configuración que pide en el log luego usar el comando anterior.

kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml

helm repo add jetstack https://charts.jetstack.io
helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.13.0 --set installCRDs=true


helm repo add pgo https://access.crunchydata.com/api/helm/pgo-full
helm repo update

# 1. LIMPIEZA FINAL CRDs (por si acaso)
kubectl delete crd $(kubectl get crd | grep postgresql.cnpg.io | awk '{print $1}') --ignore-not-found=true

# 2. CNPG OFICIAL 1.24.1 (Alpine x86-64-v1 → T2330 OK)
kubectl apply --server-side \
  -f https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-1.24/releases/cnpg-1.24.1.yaml

kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml

kubectl edit ds kube-flannel-ds -n kube-flannel

containers:
      - args:
        - --ip-masq
        - --kube-subnet-mgr
        - --iface=tailscale0  # <--- ¡AGREGA ESTA LÍNEA EXACTAMENTE AQUÍ!
        command:
        - /opt/bin/flanneld
        env:
        # ... (resto de las variables)
        
kubectl delete pod -l k8s-app=kube-dns -n kube-system
