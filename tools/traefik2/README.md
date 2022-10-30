```
helm repo add traefik https://helm.traefik.io/traefik

helm upgrade --atomic --install --create-namespace -f ./tools/values.yml -n traefik traefik traefik/traefik --version 18.1.0
```
