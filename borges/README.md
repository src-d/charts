# Borges

This chart deploys [borges](https://github.com/src-d/borges)

## Pre-requisites

- Kubernetes 1.4+
- borges v0.8.2+

## Scope

This chart supports Borges writing to HDFS or Gluster

## Installing the Chart

* To install Borges using Gluster as storage

```sh
$ helm install --name borges-release --set \
glusterfs.endpoint=<gluster k8s endpoint>,\
glusterfs.volume=<gluster volume>
```

* To install Borges using HDFS as storage

```sh
$ helm install --name borges-release --set \
hadoop.userName=<hadoop user name>,\
hadoop.connectionString=<hadoop-host:hadoop-port>
```

## Configuration

See `values.yaml` for the available configuration parameters.
