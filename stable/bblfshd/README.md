<img src="images/logo.png" width="100" align="right" vspace="20" />

# Babelfish  server

This chart deploys a [Babelfish server](https://doc.bblf.sh/)

## Official Documentation

Official project documentation found [here](https://doc.bblf.sh/)

## Prerequisites

- Kubernetes 1.4+ with Beta APIs enabled

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release bblfshd
```

## Configuration

See `values.yaml` for the available configuration parameters. Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example:

```bash
$ helm install --name my-release --set image.tag=v0.5.0 bblfshd
```
