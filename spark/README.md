# Apache Spark Helm Chart

Apache Spark is a fast and general-purpose cluster computing system

* http://spark.apache.org/

Adapted from https://github.com/kubernetes/charts/tree/master/stable/spark

## Chart Details
This chart will do the following:

* 1 x Spark Master with port 8080 exposed using a ClusterIP service
* A DaemonSet for Spark workers that can be bound to certain nodes using a node selector
* 1 x [Spark Ui Proxy](https://github.com/src-d/spark-ui-proxy) to be able to use Spark web ui behind a firewall or a reverse proxy
* All using Kubernetes Deployments

## Prerequisites

* Assumes that serviceAccount tokens are available under hostname metadata. (Works on GKE by default) URL -- http://metadata/computeMetadata/v1/instance/service-accounts/default/token

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release spark
```

### Loading the chart

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release -f values.yaml stable/spark
```

> **Tip**: You can use the default [values.yaml](values.yaml)
