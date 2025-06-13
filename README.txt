# Añadir repositorios
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Crear namespace
kubectl create namespace monitoring

# Instalar Prometheus + Grafana
helm install grafana prometheus-community/kube-prometheus-stack \
  -f kube-prometheus-stack-values.yaml \
  -n monitoring

# Instalar Loki
helm install loki grafana/loki-stack \
  -f loki-stack-values.yaml \
  -n monitoring

# Instalar Tempo
helm install tempo grafana/tempo-distributed \
  -f tempo-values.yaml \
  -n monitoring
