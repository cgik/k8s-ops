## Flux
For this setup I use [gcloud cli](https://cloud.google.com/sdk/docs/install) and [secrets](https://cloud.google.com/secret-manager) to store my [github token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) and but obviously for your setup cyou can use what you want.
You also need the [flux CLI tool](https://fluxcd.io/docs/installation/).

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