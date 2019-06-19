# EWBF Miner

This chart deploys [EWBF Miner](https://github.com/nanopool/ewbf-miner) using Docker containers created using [this image](https://github.com/src-d/ewbf-miner-docker)

## Pre-requisites

- Kubernetes 1.4+
- Kubernetes [GPU Nvidia support](https://kubernetes.io/docs/tasks/manage-gpus/scheduling-gpus/)

## Installing the Chart

To install the chart with the release name `ewbf-miner`

```sh
$ helm install --name ewbf-miner-release --set args.email=rafa@sourced.tech,args.zCashWallet=XXXXXXXX
```

See `values.yaml` for the available configuration parameters.
