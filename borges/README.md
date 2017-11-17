# Borges

This chart deploys [borges](https://github.com/src-d/borges)

## Pre-requisites

- Kubernetes 1.4+
- borges v0.8.2+

## Scope

This is intended to use Google DNS for Let's Encrypt challenges. `borges` supports more challenges, but we're currently only interested in those.

## Installing the Chart

To install the chart with the release name `borges`

```bash
helm install -n borgess-release . borges
```

## Configuration

See `values.yaml` for the available configuration parameters.

For example, to define where pods will be deployed, we can use `nodeSelector' property

```sh
$ helm install --name borges-release --set nodeSelector."srcd\.host/type"=worker
```
