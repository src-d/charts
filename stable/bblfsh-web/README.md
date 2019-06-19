<img src="images/logo.png" width="100" align="right" vspace="20" />

# Babelfish Web

This chart deploys a [web client](https://github.com/bblfsh/web) for [Babelfish](https://doc.bblf.sh/), and optionally a Babelfish server, if you don't have one running in your environment.

## Official Documentation

Official project documentation found [here](https://doc.bblf.sh/)

## Prerequisites

- Kubernetes 1.4+ with Beta APIs enabled

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release bblfsh-web
```

## Configuration

See `values.yaml` for the available configuration parameters. Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

For example, to use an existing bblfsh server we set the server address:

```sh
$ helm install --name my-release --set settings.serverAddr=1.2.3.4:9432 bblfsh-web
```
