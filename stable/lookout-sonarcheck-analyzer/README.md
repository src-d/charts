# Lookout sonarcheck analyzer

This chart deploys the [lookout sonarcheck analyzer](https://github.com/src-d/lookout-sonarcheck-analyzer)

## Prerequisites

- Kubernetes 1.4+ with Beta APIs enabled

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release lookout-sonarcheck-analyzer
```

## Configuration

See `values.yaml` for the available configuration parameters. Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

```sh
$ helm install --name my-release lookout-sonarcheck-analyzer
```
