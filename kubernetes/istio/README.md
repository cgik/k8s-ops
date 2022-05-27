# Generate a manifest
`istioctl manifest generate > istio.yaml`

# Validate installation
`istioctl verify-install -f istio.yaml`

# k3s remove treafik
`kubectl -n kube-system delete helmcharts.helm.cattle.io traefik`