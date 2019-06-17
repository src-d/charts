# Borges

This chart deploys a test git server, without authentication

## Pre-requisites

- Kubernetes 1.4+

## Installing the Chart

To install the chart with the release name `git-server`

```bash
helm install -n git-server-release . git-server
```

## Configuration

See `values.yaml` for the available configuration parameters.

For example, to define where pods will be deployed, we can use `nodeSelector' property

```sh
$ helm install --name git-server-release --set nodeSelector."srcd\.host/type"=worker
```

## TODO

* Hardcoded to use HostPath. Should move to PVC or at least give multiple possibilities
