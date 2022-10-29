
```bash
helm repo add emberstack https://emberstack.github.io/helm-charts

helm upgrade --atomic --install --create-namespace -n reflector reflector emberstack/reflector
```