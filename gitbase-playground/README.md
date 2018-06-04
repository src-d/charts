# Gitbase playground

This chart deploys [Gitbase playground](https://github.com/src-d/gitbase-playground)

It has two modes:

* It can deploy its own bblfshd and gitbase servers as sidecar containers
  * bblfshd drivers are set explicitly in the configuration to make sure every replica has the same versions. They are downloaded after bblfshd has started
  * To have gitbase data a set of repositories is downloaded before gitbase init. In order to have consistency if multiple replicas are specified a commit hash can be passed.
  * It uses a stateful set to avoid downloading again data for every release
* It can use external bblfshd and gitbase services (see `settings` key in `values.yaml`)

## Prerequisites

- Kubernetes 1.6+ with Beta APIs enabled

## Installing the Chart

* To install the chart with the release name `my-release` without ingress resource:

  ```bash
  $ helm upgrade my-release . --install --set \
  ingress.enabled=false,\
  gitbasePlayground.image.tag=latest
  ```

* To install the chart with the release name `my-release` with ingress resource:

  ```bash
  $ helm upgrade my-release . --install --set \
  ingress.globalStaticIpName=<global ip name>,\
  ingress.hostname=<dns record>,\
  gitbasePlayground.image.tag=latest
  ```

## Configuration

See `values.yaml` for the available configuration parameters. Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.
