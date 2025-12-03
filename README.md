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

aplicar los 3 codigos .yml

# Definimos las variables
ARCHIVO_LOCAL="/opt/repos/ramen-de-dockers/03-infrastructure/postgresql/kubernets/nuevo_dump_sys_gen_contracts.sql"
ARCHIVO_REMOTO="/var/lib/postgresql/data/db_restore_plano.sql"
PRIMARY_POD="contratos-db-cluster-1"

echo "Copiando y restaurando el backup plano en PG 18..."

# 2.1 Copiar el archivo al nuevo Pod Primario
kubectl cp ${ARCHIVO_LOCAL} ${PRIMARY_POD}:${ARCHIVO_REMOTO} -c postgres

# 2.2 Restaurar los datos (Usando -U postgres para permisos de superusuario)
# El dump ya contiene la creación de tablas, etc.
kubectl exec -it ${PRIMARY_POD} -c postgres -- \
  psql -U postgres -d sys-gen-contracts -f ${ARCHIVO_REMOTO}

# 2.3 Limpiar
echo "Limpiando archivo temporal..."
kubectl exec ${PRIMARY_POD} -c postgres -- rm -f ${ARCHIVO_REMOTO}

echo "🎉 ¡Base de datos PostgreSQL 18 con datos restaurados lista!"

Crear el user para psql luego ejecutar esto como buena practica

echo "Cambiando la propiedad de objetos dentro del esquema PUBLIC a perripopo..."
# Reasignamos la propiedad de todas las tablas/secuencias/vistas dentro del esquema 'public'
kubectl exec -it contratos-db-cluster-1 -c postgres -- \
  psql -U postgres -d sys-gen-contracts -c "GRANT ALL ON ALL TABLES IN SCHEMA public TO perripopo;"
kubectl exec -it contratos-db-cluster-1 -c postgres -- \
  psql -U postgres -d sys-gen-contracts -c "GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO perripopo;"
kubectl exec -it contratos-db-cluster-1 -c postgres -- \
  psql -U postgres -d sys-gen-contracts -c "GRANT ALL ON ALL FUNCTIONS IN SCHEMA public TO perripopo;"
  
  
perripopo@iuabtw:/opt/repos/ramen-de-dockers/03-infrastructure/postgresql/kubernets$ kubectl patch cluster contratos-db-cluster --type='merge' -p='{
  "spec": {
    "affinity": {
      "tolerations": [
        {
          "key": "node-role.kubernetes.io/control-plane",
          "operator": "Exists",
          "effect": "NoSchedule"
        }
      ]
    }
  }
}'
cluster.postgresql.cnpg.io/contratos-db-cluster patched

  

