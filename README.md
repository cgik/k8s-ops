# gitops

This is a monorepo for IaC related things, mostly probably containers, and kubernetes cluster setups. 

## Folder Information
`/kubernetes`: Kubernetes namespace and setups for new clusters, non-app related.

`/clusters`: Cluster configurations, handled by [fluxcd](https://fluxcd.io/).

`/tests`: Uses [conftest](https://www.conftest.dev/).

## Flux
For this setup I use gcloud secrets to store my github token and but obviously for your setup cyou can use what you want.
You also need the flux CLI tool.

```shell
export GITHUB_TOKEN=$(gcloud secrets versions access latest --secret="github-access-token")

flux bootstrap github \
  --owner=cgik \
  --repository=ops \
  --path=clusters/local \
  --personal
```

Flux kustomize is a functions a tiny bit different than you may expect, or at least I ran into an issue how [kustomization](https://kubectl.docs.kubernetes.io/installation/kustomize/binaries/) was being built with flux, for debugging I found this command useful.

```shell
kustomize build --load-restrictor=LoadRestrictionsNone --reorder=legacy . | kubectl apply --server-side --dry-run=server -f-
```