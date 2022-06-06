# gitops

This is a monorepo for IaC related things, mostly probably containers, and kubernetes cluster setups. 

## Folder Information
`/kubernetes`: Kubernetes namespace and setups for new clusters, non-app related.

`/clusters`: Cluster configurations, handled by [fluxcd](https://fluxcd.io/), you can already read the README in the folder for more info regarding flux.

`/tests`: Uses [conftest](https://www.conftest.dev/).
